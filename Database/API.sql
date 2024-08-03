USE [QLDT_API]
GO
/****** Object:  Table [dbo].[dienthoai]    Script Date: 4/27/2024 8:35:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dienthoai](
	[MaSP] [nvarchar](50) NOT NULL,
	[MaLSP] [nvarchar](50) NULL,
	[TenSP] [nvarchar](50) NULL,
	[DonGia] [int] NULL,
	[SoLuong] [int] NULL,
	[HinhAnh] [nvarchar](50) NULL,
	[TrangThai] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hoadon]    Script Date: 4/27/2024 8:35:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hoadon](
	[MaHD] [nvarchar](50) NOT NULL,
	[MaNV] [nvarchar](50) NULL,
	[MaKH] [nvarchar](50) NULL,
	[MaKM] [nvarchar](50) NULL,
	[NgayLap] [datetime] NULL,
	[TongTien] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[chitiethoadon]    Script Date: 4/27/2024 8:35:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chitiethoadon](
	[MaHD] [nvarchar](50) NOT NULL,
	[MaSP] [nvarchar](50) NOT NULL,
	[SoLuong] [int] NULL,
	[DonGia] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC,
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Thong_ke_so_luong]    Script Date: 4/27/2024 8:35:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Thong_ke_so_luong](@nam int)
returns table
as
return
(select s.MaSP, s.TenSP, sum(ct.SoLuong) as so_luong_ban from dienthoai s join chitiethoadon ct on ct.MaSP = s.MaSP
join hoadon hd on hd.MaHD = ct.MaHD
where year(hd.NgayLap) = @nam	
group by s.MaSP, s.TenSP
)
GO
/****** Object:  UserDefinedFunction [dbo].[TKDT_BYYEAR]    Script Date: 4/27/2024 8:35:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[TKDT_BYYEAR](@nam int)
returns table 
as
return
(select month(hd.NgayLap) as 'Month', sum(sp.DonGia*ct.SoLuong) as Doanh_thu from chitiethoadon ct join hoadon hd on ct.MaHD = hd.MaHD
join dienthoai sp on sp.MaSP = ct.MaSP
where year(hd.NgayLap) = @nam
group by month(hd.NgayLap))
GO
/****** Object:  Table [dbo].[chitietphieunhap]    Script Date: 4/27/2024 8:35:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chitietphieunhap](
	[MaPN] [nvarchar](50) NOT NULL,
	[MaSP] [nvarchar](50) NOT NULL,
	[SoLuong] [int] NULL,
	[DonGia] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPN] ASC,
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[khachhang]    Script Date: 4/27/2024 8:35:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[khachhang](
	[MaKH] [nvarchar](50) NOT NULL,
	[TenKH] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[SDT] [nvarchar](50) NULL,
	[TrangThai] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[loaidienthoai]    Script Date: 4/27/2024 8:35:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[loaidienthoai](
	[MaLSP] [nvarchar](50) NOT NULL,
	[TenSP] [nvarchar](50) NULL,
	[Mota] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nhacungcap]    Script Date: 4/27/2024 8:35:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nhacungcap](
	[MaNCC] [nvarchar](50) NOT NULL,
	[TenNCC] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[SDT] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nhanvien]    Script Date: 4/27/2024 8:35:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nhanvien](
	[MaNV] [nvarchar](50) NOT NULL,
	[TenNV] [nvarchar](50) NULL,
	[NgaySinh] [datetime] NULL,
	[DiaChi] [nvarchar](50) NULL,
	[SDT] [nvarchar](50) NULL,
	[TrangThai] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[phanquyen]    Script Date: 4/27/2024 8:35:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[phanquyen](
	[MaQuyen] [nvarchar](50) NOT NULL,
	[TenTaiKhoan] [nvarchar](50) NOT NULL,
	[TrangThai] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaQuyen] ASC,
	[TenTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[phieunhap]    Script Date: 4/27/2024 8:35:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[phieunhap](
	[MaPN] [nvarchar](50) NOT NULL,
	[MaNCC] [nvarchar](50) NULL,
	[MaNV] [nvarchar](50) NULL,
	[NgayNhap] [datetime] NULL,
	[TongTien] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[quyen]    Script Date: 4/27/2024 8:35:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[quyen](
	[MaQuyen] [nvarchar](50) NOT NULL,
	[TenQuyen] [nvarchar](50) NULL,
	[ChiTietQuyen] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaQuyen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[taikhoan]    Script Date: 4/27/2024 8:35:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[taikhoan](
	[TenTaiKhoan] [nvarchar](50) NOT NULL,
	[MatKhau] [nvarchar](50) NULL,
	[MaNV] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[TenTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[chitiethoadon] ([MaHD], [MaSP], [SoLuong], [DonGia]) VALUES (N'HD01', N'SP01', 2, 30000000)
INSERT [dbo].[chitiethoadon] ([MaHD], [MaSP], [SoLuong], [DonGia]) VALUES (N'HD02', N'SP02', 2, 15000000)
INSERT [dbo].[chitiethoadon] ([MaHD], [MaSP], [SoLuong], [DonGia]) VALUES (N'HD02', N'SP03', 1, 25000000)
INSERT [dbo].[chitiethoadon] ([MaHD], [MaSP], [SoLuong], [DonGia]) VALUES (N'HD03', N'SP03', 1, 25000000)
INSERT [dbo].[chitiethoadon] ([MaHD], [MaSP], [SoLuong], [DonGia]) VALUES (N'HD04', N'SP04', 3, 15000000)
INSERT [dbo].[chitiethoadon] ([MaHD], [MaSP], [SoLuong], [DonGia]) VALUES (N'HD05', N'SP05', 1, 12000000)
INSERT [dbo].[chitiethoadon] ([MaHD], [MaSP], [SoLuong], [DonGia]) VALUES (N'HD06', N'SP07', 5, 9000000)
INSERT [dbo].[chitiethoadon] ([MaHD], [MaSP], [SoLuong], [DonGia]) VALUES (N'HD07', N'SP10', 4, 5000000)
INSERT [dbo].[chitiethoadon] ([MaHD], [MaSP], [SoLuong], [DonGia]) VALUES (N'HD08', N'SP08', 3, 6500000)
GO
INSERT [dbo].[dienthoai] ([MaSP], [MaLSP], [TenSP], [DonGia], [SoLuong], [HinhAnh], [TrangThai]) VALUES (N'SP01', N'LSP01', N'Iphone 15', 30000000, 30, N'iphone.jpg', 1)
INSERT [dbo].[dienthoai] ([MaSP], [MaLSP], [TenSP], [DonGia], [SoLuong], [HinhAnh], [TrangThai]) VALUES (N'SP02', N'LSP02', N'SamSung Galaxy', 15000000, 15, N'samsung.jpg', 1)
INSERT [dbo].[dienthoai] ([MaSP], [MaLSP], [TenSP], [DonGia], [SoLuong], [HinhAnh], [TrangThai]) VALUES (N'SP03', N'LSP01', N'Iphone14', 25000000, 10, NULL, 1)
INSERT [dbo].[dienthoai] ([MaSP], [MaLSP], [TenSP], [DonGia], [SoLuong], [HinhAnh], [TrangThai]) VALUES (N'SP04', N'LSP01', N'Ihone13', 15000000, 25, NULL, 1)
INSERT [dbo].[dienthoai] ([MaSP], [MaLSP], [TenSP], [DonGia], [SoLuong], [HinhAnh], [TrangThai]) VALUES (N'SP05', N'LSP03', N'VPhone12', 10000000, 15, NULL, 1)
INSERT [dbo].[dienthoai] ([MaSP], [MaLSP], [TenSP], [DonGia], [SoLuong], [HinhAnh], [TrangThai]) VALUES (N'SP06', N'LSP03', N'BPhone', 12000000, 12, NULL, 1)
INSERT [dbo].[dienthoai] ([MaSP], [MaLSP], [TenSP], [DonGia], [SoLuong], [HinhAnh], [TrangThai]) VALUES (N'SP07', N'LSP02', N'Realme7', 9000000, 9, NULL, 1)
INSERT [dbo].[dienthoai] ([MaSP], [MaLSP], [TenSP], [DonGia], [SoLuong], [HinhAnh], [TrangThai]) VALUES (N'SP08', N'LSP02', N'Oppo', 6500000, 17, NULL, 1)
INSERT [dbo].[dienthoai] ([MaSP], [MaLSP], [TenSP], [DonGia], [SoLuong], [HinhAnh], [TrangThai]) VALUES (N'SP09', N'LSP02', N'SamSungProMax', 11000000, 5, NULL, 1)
INSERT [dbo].[dienthoai] ([MaSP], [MaLSP], [TenSP], [DonGia], [SoLuong], [HinhAnh], [TrangThai]) VALUES (N'SP10', N'LSP03', N'Nokia', 5000000, 13, NULL, 1)
GO
INSERT [dbo].[hoadon] ([MaHD], [MaNV], [MaKH], [MaKM], [NgayLap], [TongTien]) VALUES (N'HD01', N'NV02', N'KH01', NULL, CAST(N'2024-01-30T00:00:00.000' AS DateTime), 60000000)
INSERT [dbo].[hoadon] ([MaHD], [MaNV], [MaKH], [MaKM], [NgayLap], [TongTien]) VALUES (N'HD02', N'NV02', N'KH02', NULL, CAST(N'2024-01-15T00:00:00.000' AS DateTime), 27000000)
INSERT [dbo].[hoadon] ([MaHD], [MaNV], [MaKH], [MaKM], [NgayLap], [TongTien]) VALUES (N'HD03', N'NV02', N'KH03', NULL, CAST(N'2024-02-15T00:00:00.000' AS DateTime), 9000000)
INSERT [dbo].[hoadon] ([MaHD], [MaNV], [MaKH], [MaKM], [NgayLap], [TongTien]) VALUES (N'HD04', N'NV02', N'KH04', NULL, CAST(N'2024-02-25T00:00:00.000' AS DateTime), 100000)
INSERT [dbo].[hoadon] ([MaHD], [MaNV], [MaKH], [MaKM], [NgayLap], [TongTien]) VALUES (N'HD05', N'NV02', N'KH05', NULL, CAST(N'2024-03-17T00:00:00.000' AS DateTime), 30000000)
INSERT [dbo].[hoadon] ([MaHD], [MaNV], [MaKH], [MaKM], [NgayLap], [TongTien]) VALUES (N'HD06', N'NV02', N'KH06', NULL, CAST(N'2024-03-27T00:00:00.000' AS DateTime), 15000000)
INSERT [dbo].[hoadon] ([MaHD], [MaNV], [MaKH], [MaKM], [NgayLap], [TongTien]) VALUES (N'HD07', N'NV02', N'KH07', NULL, CAST(N'2024-04-10T00:00:00.000' AS DateTime), 60000000)
INSERT [dbo].[hoadon] ([MaHD], [MaNV], [MaKH], [MaKM], [NgayLap], [TongTien]) VALUES (N'HD08', N'NV02', N'KH08', NULL, CAST(N'2024-04-20T00:00:00.000' AS DateTime), 5000000)
GO
INSERT [dbo].[khachhang] ([MaKH], [TenKH], [DiaChi], [SDT], [TrangThai]) VALUES (N'KH01', N'Nguyen Tien Hoan', N'Ha Tay', N'098213123', 1)
INSERT [dbo].[khachhang] ([MaKH], [TenKH], [DiaChi], [SDT], [TrangThai]) VALUES (N'KH02', N'Nguyen Van Chien', N'Nghe An', N'123123213123', 1)
INSERT [dbo].[khachhang] ([MaKH], [TenKH], [DiaChi], [SDT], [TrangThai]) VALUES (N'KH03', N'Hoang Van Phuong', N'Thanh Hoa', N'0213232136', 1)
INSERT [dbo].[khachhang] ([MaKH], [TenKH], [DiaChi], [SDT], [TrangThai]) VALUES (N'KH04', N'Au Duc Nga', N'Nghe An', N'04646934853', 1)
INSERT [dbo].[khachhang] ([MaKH], [TenKH], [DiaChi], [SDT], [TrangThai]) VALUES (N'KH05', N'Nguyen Tien Dung', N'Ha Noi', N'034823472348', 1)
INSERT [dbo].[khachhang] ([MaKH], [TenKH], [DiaChi], [SDT], [TrangThai]) VALUES (N'KH06', N'Nguyen Van An', N'Ha Noi', N'0989234234', 1)
INSERT [dbo].[khachhang] ([MaKH], [TenKH], [DiaChi], [SDT], [TrangThai]) VALUES (N'KH07', N'Bui Phuong Nam', N'Ha Noi', N'09832421231', 1)
INSERT [dbo].[khachhang] ([MaKH], [TenKH], [DiaChi], [SDT], [TrangThai]) VALUES (N'KH08', N'Pham Van Nam', N'Ha Nam', N'098324234', 1)
INSERT [dbo].[khachhang] ([MaKH], [TenKH], [DiaChi], [SDT], [TrangThai]) VALUES (N'KH09', N'Ngo Tuan Tu', N'Thach That', N'09821312113', 1)
GO
INSERT [dbo].[loaidienthoai] ([MaLSP], [TenSP], [Mota]) VALUES (N'LSP01', N'Apple', N'He dieu hanh IOS')
INSERT [dbo].[loaidienthoai] ([MaLSP], [TenSP], [Mota]) VALUES (N'LSP02', N'SamSung', NULL)
INSERT [dbo].[loaidienthoai] ([MaLSP], [TenSP], [Mota]) VALUES (N'LSP03', N'Gaming', NULL)
INSERT [dbo].[loaidienthoai] ([MaLSP], [TenSP], [Mota]) VALUES (N'LSP04', N'Nokia', NULL)
INSERT [dbo].[loaidienthoai] ([MaLSP], [TenSP], [Mota]) VALUES (N'LSP05', N'tile', NULL)
GO
INSERT [dbo].[nhacungcap] ([MaNCC], [TenNCC], [DiaChi], [SDT], [Fax]) VALUES (N'NCC01', N'NokiaStore', N'HaDong', N'0422231231', NULL)
INSERT [dbo].[nhacungcap] ([MaNCC], [TenNCC], [DiaChi], [SDT], [Fax]) VALUES (N'NCC02', N'AppleStore', N'America', N'02131231', NULL)
INSERT [dbo].[nhacungcap] ([MaNCC], [TenNCC], [DiaChi], [SDT], [Fax]) VALUES (N'NCC03', N'SamSungCompany', N'Seoul', N'123123123', NULL)
GO
INSERT [dbo].[nhanvien] ([MaNV], [TenNV], [NgaySinh], [DiaChi], [SDT], [TrangThai]) VALUES (N'NV01', N'Chu Van Dung', CAST(N'2003-04-10T00:00:00.000' AS DateTime), N'Ha Dong', N'0989133890', 1)
INSERT [dbo].[nhanvien] ([MaNV], [TenNV], [NgaySinh], [DiaChi], [SDT], [TrangThai]) VALUES (N'NV02', N'Pham Van Linh', CAST(N'2003-09-21T00:00:00.000' AS DateTime), N'Bac Giang', N'012343242', 1)
INSERT [dbo].[nhanvien] ([MaNV], [TenNV], [NgaySinh], [DiaChi], [SDT], [TrangThai]) VALUES (N'NV03', N'Vu Quang Truong', CAST(N'2003-10-15T00:00:00.000' AS DateTime), N'Hoa Binh', N'01212321321', 1)
INSERT [dbo].[nhanvien] ([MaNV], [TenNV], [NgaySinh], [DiaChi], [SDT], [TrangThai]) VALUES (N'NV04', N'Nguyen Nhat Truong', CAST(N'2003-08-15T00:00:00.000' AS DateTime), N'Cau Giay', N'01212321321', 1)
GO
INSERT [dbo].[phanquyen] ([MaQuyen], [TenTaiKhoan], [TrangThai]) VALUES (N'MQ01', N'admin', 1)
INSERT [dbo].[phanquyen] ([MaQuyen], [TenTaiKhoan], [TrangThai]) VALUES (N'MQ02', N'pvlinh', 1)
INSERT [dbo].[phanquyen] ([MaQuyen], [TenTaiKhoan], [TrangThai]) VALUES (N'MQ03', N'vqtruong', 1)
GO
INSERT [dbo].[phieunhap] ([MaPN], [MaNCC], [MaNV], [NgayNhap], [TongTien]) VALUES (N'PN01', N'NCC01', N'NV01', CAST(N'2024-01-09T00:00:00.000' AS DateTime), 1000000000)
INSERT [dbo].[phieunhap] ([MaPN], [MaNCC], [MaNV], [NgayNhap], [TongTien]) VALUES (N'PN02', N'NCC02', N'NV03', CAST(N'2024-02-09T00:00:00.000' AS DateTime), 900000000)
INSERT [dbo].[phieunhap] ([MaPN], [MaNCC], [MaNV], [NgayNhap], [TongTien]) VALUES (N'PN03', N'NCC03', N'NV03', CAST(N'2024-03-09T00:00:00.000' AS DateTime), 150000000)
GO
INSERT [dbo].[quyen] ([MaQuyen], [TenQuyen], [ChiTietQuyen]) VALUES (N'MQ01', N'Admin', N'Quan ly')
INSERT [dbo].[quyen] ([MaQuyen], [TenQuyen], [ChiTietQuyen]) VALUES (N'MQ02', N'Nhanvien', N'Ban hang')
INSERT [dbo].[quyen] ([MaQuyen], [TenQuyen], [ChiTietQuyen]) VALUES (N'MQ03', N'Thu kho', N'Quan ly xuat nhap hang')
GO
INSERT [dbo].[taikhoan] ([TenTaiKhoan], [MatKhau], [MaNV]) VALUES (N'admin', N'123456', N'NV01')
INSERT [dbo].[taikhoan] ([TenTaiKhoan], [MatKhau], [MaNV]) VALUES (N'nntruong', N'123456', N'NV04')
INSERT [dbo].[taikhoan] ([TenTaiKhoan], [MatKhau], [MaNV]) VALUES (N'pvlinh', N'123456', N'NV02')
INSERT [dbo].[taikhoan] ([TenTaiKhoan], [MatKhau], [MaNV]) VALUES (N'vqtruong', N'123456', N'NV03')
GO
ALTER TABLE [dbo].[chitiethoadon]  WITH CHECK ADD FOREIGN KEY([MaHD])
REFERENCES [dbo].[hoadon] ([MaHD])
GO
ALTER TABLE [dbo].[chitiethoadon]  WITH CHECK ADD FOREIGN KEY([MaSP])
REFERENCES [dbo].[dienthoai] ([MaSP])
GO
ALTER TABLE [dbo].[chitietphieunhap]  WITH CHECK ADD FOREIGN KEY([MaPN])
REFERENCES [dbo].[phieunhap] ([MaPN])
GO
ALTER TABLE [dbo].[chitietphieunhap]  WITH CHECK ADD FOREIGN KEY([MaSP])
REFERENCES [dbo].[dienthoai] ([MaSP])
GO
ALTER TABLE [dbo].[dienthoai]  WITH CHECK ADD FOREIGN KEY([MaLSP])
REFERENCES [dbo].[loaidienthoai] ([MaLSP])
GO
ALTER TABLE [dbo].[hoadon]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[khachhang] ([MaKH])
GO
ALTER TABLE [dbo].[hoadon]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[nhanvien] ([MaNV])
GO
ALTER TABLE [dbo].[phanquyen]  WITH CHECK ADD FOREIGN KEY([MaQuyen])
REFERENCES [dbo].[quyen] ([MaQuyen])
GO
ALTER TABLE [dbo].[phanquyen]  WITH CHECK ADD FOREIGN KEY([TenTaiKhoan])
REFERENCES [dbo].[taikhoan] ([TenTaiKhoan])
GO
ALTER TABLE [dbo].[phieunhap]  WITH CHECK ADD FOREIGN KEY([MaNCC])
REFERENCES [dbo].[nhacungcap] ([MaNCC])
GO
ALTER TABLE [dbo].[phieunhap]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[nhanvien] ([MaNV])
GO
ALTER TABLE [dbo].[taikhoan]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[nhanvien] ([MaNV])
GO
