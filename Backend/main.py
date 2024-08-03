import pyodbc
import flask
from Config import conn_str
from flask import send_file, send_from_directory, request
from werkzeug.utils import secure_filename
import os

try:
    conn = pyodbc.connect(conn_str)
    app = flask.Flask(__name__)
    # IMAGE_DIRECTORY = 'D:\Nam3_2_ChuDung\API_auth\BTL2\ImagePhone'

    # GETALL
    @app.route('/phone', methods=['GET'])
    def getAllPhone():
        Cusor = conn.cursor()
        sql = 'select dt.MaSP, l.TenSP as TenLoaiSP, dt.TenSP, dt.DonGia, dt.SoLuong,dt.HinhAnh, dt.TrangThai, dt.RAM, dt.SIM, dt.CameraSau, dt.CameraTruoc from dienthoai  dt join loaidienthoai l on dt.MaLSP = l.MaLSP where TrangThai = 1'
        Cusor.execute(sql)
        results = []
        keys = []
        for i in Cusor.description:
            keys.append(i[0])
        for i in Cusor.fetchall():
            results.append(dict(zip(keys, i)))
        reps = flask.jsonify(results)
        reps.status = 200
        return reps
    
    #INSERT
    @app.route('/phone/insert', methods=['POST'])
    def insertPhone():
        try:
            Cursor = conn.cursor()
            maSp = flask.request.json.get("MaSP")
            maLsp = flask.request.json.get("MaLSP")
            tenSp = flask.request.json.get("TenSP")
            donGia = flask.request.json.get("DonGia")
            soLuong = flask.request.json.get("SoLuong")
            hinhAnh = flask.request.json.get("HinhAnh")
            trangThai = flask.request.json.get("TrangThai")
            ram = flask.request.json.get("RAM")
            sim = flask.request.json.get("SIM")
            CameraSau = flask.request.json.get("CameraSau")
            CameraTruoc = flask.request.json.get("CameraTruoc")

            data = (maSp, maLsp, tenSp, int(donGia), int(soLuong), hinhAnh, int(trangThai), ram, sim, CameraSau, CameraTruoc)
            print(data)
            sql = "insert into dienthoai values (?,?,?,?,?,?,?,?,?,?,?)"
            Cursor.execute(sql, data)
            Cursor.commit()
            res = flask.jsonify({"mess": "successfully"})
            return res, 200
        except Exception as e:
            res = flask.jsonify({"mess": e})
            return res, 200
    #delete
    @app.route('/phone/delete', methods=['PUT'])
    def deletePhone():
        try:
            Cursor = conn.cursor()
            maSp = flask.request.json.get("masp")
            sql = "update dienthoai set TrangThai = 0 Where MaSP = ?"
            Cursor.execute(sql, (maSp,))
            Cursor.commit()
            res = flask.jsonify({"mess": "Deleted!"})
            return res, 200
        except Exception as e:
            res = flask.jsonify({"mess": e})
            return res, 200
    #Sua
    @app.route('/phone/update', methods = ['PUT'])
    def updatePhone():
        try:
            Cursor = conn.cursor()
            maSp = flask.request.json.get("MaSP")
            maLsp = flask.request.json.get("MaLSP")
            tenSp = flask.request.json.get("TenSP")
            donGia = flask.request.json.get("DonGia")
            soLuong = flask.request.json.get("SoLuong")
            hinhAnh = flask.request.json.get("HinhAnh")
            trangThai = flask.request.json.get("TrangThai")
            ram = flask.request.json.get("RAM")
            sim = flask.request.json.get("SIM")
            CameraSau = flask.request.json.get("CameraSau")
            CameraTruoc = flask.request.json.get("CameraTruoc")
            trangThai = 1
            sql = '''update dienthoai 
                        set MaLSP=?, 
                        TenSP=?, 
                        DonGia=?, 
                        SoLuong=?, 
                        HinhAnh=?,
                        TrangThai=?,
                        RAM=?,
                        SIM=?,
                        CameraSau=?,
                        CameraTruoc=?
                        Where MaSP = ?
                    '''
            Cursor.execute(sql, (maLsp, tenSp, donGia, soLuong, hinhAnh, trangThai,ram, sim, CameraSau, CameraTruoc, maSp))
            Cursor.commit()
            res = flask.jsonify({"mess": "Updated!"})
            return res, 200
        except Exception as e:
            res = flask.jsonify({"mess": e})
            return res, 200
    #Get LoaiSp
    @app.route('/loaiSp/getAll', methods=['GET'])
    def getallLoaiSp():
        Cusor = conn.cursor()
        sql = 'select * from loaidienthoai'
        Cusor.execute(sql)
        results = []
        keys = []
        for i in Cusor.description:
            keys.append(i[0])
        for i in Cusor.fetchall():
            results.append(dict(zip(keys, i)))
        reps = flask.jsonify(results)
        reps.status = 200
        return reps
    
    @app.route('/images/<filename>', methods=['GET'])
    def get_image(filename):
        image_dir = r'D:\Nam3_2_ChuDung\API_auth\BTL2\ImagePhone'
        return send_file(f"{image_dir}\\{filename}", mimetype='image/jpeg')
    
    #Them anh
    @app.route('/images/add-image', methods=['POST'])
    def add_image():
        if 'image' not in request.files:
            return flask.jsonify({'error': 'No image file uploaded'}), 400

        image_file = request.files['image']

        filename = secure_filename(image_file.filename)

        image_file.save(os.path.join('D:/Nam3_2_ChuDung/API_auth/BTL2/ImagePhone', filename))

        return flask.jsonify({'message': 'Image uploaded successfully', 'filename': filename}), 200

    # Sinh ma
    @app.route('/maSPMax', methods=['GET'])
    def sinh_ma():
        cursor = conn.cursor()
        sql ='''
            select TOP 1 dt.MaSP, l.TenSP as TenLoaiSP, dt.TenSP, dt.DonGia, dt.SoLuong,dt.HinhAnh, dt.TrangThai 
            from dienthoai  dt join loaidienthoai l on dt.MaLSP = l.MaLSP
            order by dt.MaSP desc
            '''
        cursor.execute(sql)
        result = {}
        keys = []
        for i in cursor.description:
            keys.append(i[0])
        for i in cursor.fetchall():
            result = (dict(zip(keys, i)))
        res = flask.jsonify(result)
        res.status_code = 200
        return res
    @app.route('/loaiSp', methods=['GET'])
    def get_loai_sp():
        cursor = conn.cursor()
        sql = '''select * from loaidienthoai'''
        cursor.execute(sql)
        res = []
        keys = [i[0] for i in cursor.description]
        for i in cursor.fetchall():
            res.append(dict(zip(keys, i)))
        return res, 200
    

    # API signup
    @app.route('/account/signup/', methods=['POST'])
    def signup():
        try:
            ten_tai_khoan = flask.request.json.get("tk")
            mat_khau =flask.request.json.get("mk")
            ma_nv = flask.request.json.get("ma_nv")
            cursor = conn.cursor()
            cursor.execute("EXEC ThemTaiKhoan ?, ?, ?", (ten_tai_khoan, mat_khau, ma_nv))
            result = cursor.fetchone()
            if result:
                TenTaiKhoan,message = result
                if TenTaiKhoan is not None:
                    res = flask.jsonify({"TenTaiKhoan": TenTaiKhoan,"message": message})
                    res.status_code = 200
                else:
                    res = flask.jsonify({"message": message})
                    res.status_code = 401
            else:
                res = flask.jsonify({"message": "An error occurred!!!"})
                res.status_code = 500
        except Exception as e:
            print("Error:", e)
            res = flask.jsonify({"message": "An error occurred!!!!!!"})
            res.status_code = 500
        return res

    @app.route('/account/login/', methods=['POST'])
    def login():
        try:
            username = flask.request.json.get("TenTaiKhoan")
            password = flask.request.json.get("MatKhau")
            cursor = conn.cursor()
            cursor.execute("EXEC Login ?, ?", (username, password))
            result = cursor.fetchone()
            if result:
                ma_nv, ma_quyen, ten_dang_nhap, message = result
                if ma_nv is not None:
                    res = flask.jsonify({"MaNV": ma_nv, "MaQuyen": ma_quyen, "TenDangNhap": ten_dang_nhap, "message": message})
                    res.status_code = 200
                else:
                    res = flask.jsonify({"message": message})
                    res.status_code = 401
            else:
                res = flask.jsonify({"message": "An error occurred"})
                res.status_code = 500 
        except Exception as e:
            print("Error:", e)
            res = flask.jsonify({"message": "An error occurred"})
            res.status_code = 500 
        return res
    
    #them khách hàng
    @app.route('/customer/add/', methods=['POST'])
    def add_customer():
        try:
            ma_kh = flask.request.json.get("MaKH")
            ten_kh = flask.request.json.get("TenKH")
            dia_chi = flask.request.json.get("DiaChi")
            sdt = flask.request.json.get("SDT")

            cursor = conn.cursor()
            cursor.execute("EXEC ThemKhachHang ?, ?, ?, ?", (ma_kh, ten_kh, dia_chi, sdt))
            cursor.commit()
            res = flask.jsonify({"message" : "Thanh cong"})
            res.status_code = 200
        except Exception as e:
            print("Error:", e)
            res = flask.jsonify({"message": "Fail"})
            res.status_code = 500
        return res
    #xoa khach hang
    @app.route('/customer/delete/', methods=['POST'])
    def delete_customer():
        try:
            data = flask.request.json
            ma_kh = data.get("MaKH")

            cursor = conn.cursor()
            cursor.execute("EXEC XoaKhachHang ?", (ma_kh))
            cursor.commit()
            res = flask.jsonify({"message" : "Thanh cong"})
            res.status_code = 200
        except Exception as e:
            print("Error:", e)
            res = flask.jsonify({"message": "Lỗi khi xóa khách hàng"})
            res.status_code = 501

        return res
    #danh sách khách hàng
    @app.route('/customers/views', methods=['GET'])
    def get_customers():
        try:
            cursor = conn.cursor()
            cursor.execute("EXEC LayKhachHang")
            rows = cursor.fetchall()

            customers = []
            for row in rows:
                customer = {
                    "MaKH": row[0],
                    "TenKH": row[1],
                    "DiaChi": row[2],
                    "SDT": row[3]
                }
                customers.append(customer)

            res = flask.jsonify(customers)
            res.status_code = 200
        except Exception as e:
            print("Error:", e)
            res = flask.jsonify({"message": "Lỗi khi lấy danh sách khách hàng"})
            res.status_code = 500  # Lỗi máy chủ nội bộ
        return res
    

    #Sửa khách hàng
    @app.route('/customer/update/', methods=['POST'])
    def update_customer():
        try:
            data = flask.request.json
            ma_kh = data.get("MaKH")
            ten_kh = data.get("TenKH")
            dia_chi = data.get("DiaChi")
            sdt = data.get("SDT")

            cursor = conn.cursor()
            cursor.execute("EXEC SuaKhachHang @MaKH = ?, @TenKH = ?, @DiaChi = ?, @SDT = ?", (ma_kh, ten_kh, dia_chi, sdt))
            conn.commit()  # Commit thay đổi vào cơ sở dữ liệu

            # Kiểm tra xem có bao nhiêu hàng đã được cập nhật
            rows_affected = cursor.rowcount

            if rows_affected > 0:
                message = "Cập nhật thông tin khách hàng thành công"
                res = flask.jsonify({"message": message})
                res.status_code = 200
            else:
                message = "Không tìm thấy khách hàng cần cập nhật"
                res = flask.jsonify({"message": message})
                res.status_code = 404

        except Exception as e:
            print("Error:", e)
            message = "Lỗi khi cập nhật thông tin khách hàng"
            res = flask.jsonify({"message": message})
            res.status_code = 500 

        return res
    if __name__ == "__main__":
       app.run(host = '192.168.0.104',port=3333) 
except Exception as e:
    print(e)