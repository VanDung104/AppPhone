import random
import datetime

# Các thông tin mẫu để tạo log
ip_addresses = ["192.168.1.1", "192.168.1.2", "192.168.1.3", "192.168.1.4"]
urls = ["/home", "/about", "/contact", "/products", "/blog"]
status_codes = ["200", "301", "404", "500"]
user_agents = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36",
    "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1",
    "Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; AS; rv:11.0) like Gecko"
]

# Hàm tạo dòng log
def create_log_line():
    ip = random.choice(ip_addresses)
    timestamp = datetime.datetime.now().strftime('%d/%b/%Y:%H:%M:%S %z')
    url = random.choice(urls)
    status = random.choice(status_codes)
    user_agent = random.choice(user_agents)
    return f'{ip} - - [{timestamp}] "GET {url} HTTP/1.1" {status} - "{user_agent}"\n'

# Tạo và ghi dữ liệu vào file weblog.log
with open("D:\SAMSUNG DATA\Chapter4_\Lab C4U1\weblog.log", "w") as file:
    for _ in range(100):  # Số dòng log cần tạo
        file.write(create_log_line())