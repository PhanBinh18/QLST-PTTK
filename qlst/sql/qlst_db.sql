-- =====================================================================
-- CƠ SỞ DỮ LIỆU HỆ THỐNG QUẢN LÝ SIÊU THỊ ĐIỆN MÁY (QLST - ĐỀ SỐ 8)
-- Sinh viên: Bùi Văn Bình - Mã SV: B23DCCN087
-- Hệ quản trị CSDL: MySQL 8.0+
-- =====================================================================

DROP DATABASE IF EXISTS qlst_db;
CREATE DATABASE qlst_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE qlst_db;

-- 1. Bảng Địa chỉ (tblAddress7)
CREATE TABLE tblAddress7 (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    streetAddress VARCHAR(255) NOT NULL,
    ward VARCHAR(255) NOT NULL,
    district VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Bảng Thành viên (tblMember7) - Gộp FullName7 (1-1)
CREATE TABLE tblMember7 (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    firstName VARCHAR(255) NOT NULL,
    middleName VARCHAR(255) NULL,
    lastName VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    role VARCHAR(20) NOT NULL,
    note VARCHAR(255) NULL,
    tblAddress7id INT(10) NOT NULL,
    CONSTRAINT fk_member_address7 FOREIGN KEY (tblAddress7id) REFERENCES tblAddress7(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Bảng Khách hàng (tblCustomer7) - Kế thừa từ tblMember7
CREATE TABLE tblCustomer7 (
    tblMember7id INT(10) PRIMARY KEY,
    customerType VARCHAR(50) NULL,
    CONSTRAINT fk_customer_member7 FOREIGN KEY (tblMember7id) REFERENCES tblMember7(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Bảng Nhân viên (tblEmployee7) - Kế thừa từ tblMember7
CREATE TABLE tblEmployee7 (
    tblMember7id INT(10) PRIMARY KEY,
    position VARCHAR(100) NOT NULL,
    salary DECIMAL(15, 2) NOT NULL,
    CONSTRAINT fk_employee_member7 FOREIGN KEY (tblMember7id) REFERENCES tblMember7(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Bảng Nhà cung cấp (tblSupplier7)
CREATE TABLE tblSupplier7 (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    taxCode VARCHAR(50) NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255) NULL,
    tblAddress7id INT(10) NOT NULL,
    CONSTRAINT fk_supplier_address7 FOREIGN KEY (tblAddress7id) REFERENCES tblAddress7(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. Bảng Hãng sản xuất / Thương hiệu (tblBrand7)
CREATE TABLE tblBrand7 (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    description VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 7. Bảng Danh mục mặt hàng (tblCategory7)
CREATE TABLE tblCategory7 (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 8. Bảng Dòng sản phẩm (tblProduct7)
CREATE TABLE tblProduct7 (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    modelCode VARCHAR(255) NOT NULL,
    description VARCHAR(255) NULL,
    tblBrand7id INT(10) NOT NULL,
    tblCategory7id INT(10) NOT NULL,
    CONSTRAINT fk_product_brand7 FOREIGN KEY (tblBrand7id) REFERENCES tblBrand7(id),
    CONSTRAINT fk_product_category7 FOREIGN KEY (tblCategory7id) REFERENCES tblCategory7(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 9. Bảng Biến thể mặt hàng (tblVariant7) - Gộp Inventory7 (1-1)
CREATE TABLE tblVariant7 (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(100) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(15, 2) NOT NULL,
    warrantyMonths INT(10) NOT NULL,
    status VARCHAR(50) NOT NULL,
    quantity INT(10) NOT NULL DEFAULT 0,
    reservedQuantity INT(10) NOT NULL DEFAULT 0,
    imageUrl VARCHAR(500) NULL,
    tblProduct7id INT(10) NOT NULL,
    CONSTRAINT fk_variant_product7 FOREIGN KEY (tblProduct7id) REFERENCES tblProduct7(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 10. Bảng Thông số kỹ thuật (tblSpecification7)
CREATE TABLE tblSpecification7 (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    unit VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 11. Bảng Quy cách thông số theo danh mục (tblCategorySpecification7)
CREATE TABLE tblCategorySpecification7 (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    displayOrder INT(10) NOT NULL,
    isRequired TINYINT(1) NOT NULL DEFAULT 1,
    tblSpecification7id INT(10) NOT NULL,
    tblCategory7id INT(10) NOT NULL,
    CONSTRAINT fk_catspec_spec7 FOREIGN KEY (tblSpecification7id) REFERENCES tblSpecification7(id),
    CONSTRAINT fk_catspec_category7 FOREIGN KEY (tblCategory7id) REFERENCES tblCategory7(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 12. Bảng Giá trị thông số của biến thể (tblVariantSpecification7)
CREATE TABLE tblVariantSpecification7 (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    specValue VARCHAR(255) NULL,
    tblVariant7id INT(10) NOT NULL,
    tblSpecification7id INT(10) NOT NULL,
    CONSTRAINT fk_varspec_variant7 FOREIGN KEY (tblVariant7id) REFERENCES tblVariant7(id) ON DELETE CASCADE,
    CONSTRAINT fk_varspec_spec7 FOREIGN KEY (tblSpecification7id) REFERENCES tblSpecification7(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 13. Bảng Phiếu nhập hàng (tblImportRecord7)
CREATE TABLE tblImportRecord7 (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    recordCode VARCHAR(50) NOT NULL UNIQUE,
    importDate DATE NOT NULL,
    totalCost DECIMAL(15, 2) NOT NULL,
    tblSupplier7id INT(10) NOT NULL,
    tblEmployee7tblMember7id INT(10) NOT NULL,
    CONSTRAINT fk_import_supplier7 FOREIGN KEY (tblSupplier7id) REFERENCES tblSupplier7(id),
    CONSTRAINT fk_import_employee7 FOREIGN KEY (tblEmployee7tblMember7id) REFERENCES tblEmployee7(tblMember7id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 14. Bảng Chi tiết phiếu nhập (tblImportItem7)
CREATE TABLE tblImportItem7 (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    quantity INT(10) NOT NULL,
    importPrice DECIMAL(15, 2) NOT NULL,
    subTotal DECIMAL(15, 2) NOT NULL,
    importRecordId INT(10) NOT NULL,
    variantId INT(10) NOT NULL,
    CONSTRAINT fk_importitem_record7 FOREIGN KEY (importRecordId) REFERENCES tblImportRecord7(id) ON DELETE CASCADE,
    CONSTRAINT fk_importitem_variant7 FOREIGN KEY (variantId) REFERENCES tblVariant7(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 15. Bảng Đơn hàng (tblOrder7)
CREATE TABLE tblOrder7 (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    orderCode VARCHAR(50) NOT NULL UNIQUE,
    orderDate DATE NOT NULL,
    updateAt DATE NULL,
    status VARCHAR(50) NOT NULL,
    totalAmount DECIMAL(15, 2) NOT NULL,
    tblCustomer7tblMember7id INT(10) NULL,
    CONSTRAINT fk_order_customer7 FOREIGN KEY (tblCustomer7tblMember7id) REFERENCES tblCustomer7(tblMember7id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 16. Bảng Đơn đặt hàng trực tuyến (tblOrderOnline7) - Kế thừa từ tblOrder7
CREATE TABLE tblOrderOnline7 (
    tblOrder7id INT(10) PRIMARY KEY,
    receiverName VARCHAR(255) NOT NULL,
    receiverEmail VARCHAR(255) NULL,
    receiverPhone VARCHAR(20) NOT NULL,
    shippingFee DECIMAL(15, 2) NOT NULL DEFAULT 100000.00,
    note VARCHAR(255) NULL,
    tblAddress7id INT(10) NOT NULL,
    tblEmployee7tblMember7id INT(10) NULL,
    CONSTRAINT fk_orderonline_order7 FOREIGN KEY (tblOrder7id) REFERENCES tblOrder7(id) ON DELETE CASCADE,
    CONSTRAINT fk_orderonline_address7 FOREIGN KEY (tblAddress7id) REFERENCES tblAddress7(id),
    CONSTRAINT fk_orderonline_approver7 FOREIGN KEY (tblEmployee7tblMember7id) REFERENCES tblEmployee7(tblMember7id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 17. Bảng Đơn mua tại quầy (tblInstoreOrder7) - Kế thừa từ tblOrder7
CREATE TABLE tblInstoreOrder7 (
    tblOrder7id INT(10) PRIMARY KEY,
    buyerName VARCHAR(255) NULL,
    buyerPhone VARCHAR(255) NULL,
    tblEmployee7tblMember7id INT(10) NOT NULL,
    CONSTRAINT fk_instore_order7 FOREIGN KEY (tblOrder7id) REFERENCES tblOrder7(id) ON DELETE CASCADE,
    CONSTRAINT fk_instore_creator7 FOREIGN KEY (tblEmployee7tblMember7id) REFERENCES tblEmployee7(tblMember7id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 18. Bảng Chi tiết đơn hàng (tblOrderItem7)
CREATE TABLE tblOrderItem7 (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    quantity INT(10) NOT NULL,
    unitPrice DECIMAL(15, 2) NOT NULL,
    subTotal DECIMAL(15, 2) NOT NULL,
    tblOrder7id INT(10) NOT NULL,
    tblVariant7id INT(10) NOT NULL,
    CONSTRAINT fk_orderitem_order7 FOREIGN KEY (tblOrder7id) REFERENCES tblOrder7(id) ON DELETE CASCADE,
    CONSTRAINT fk_orderitem_variant7 FOREIGN KEY (tblVariant7id) REFERENCES tblVariant7(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 19. Bảng Hóa đơn (tblInvoice7)
CREATE TABLE tblInvoice7 (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    invoiceCode VARCHAR(50) NOT NULL UNIQUE,
    createdDate DATE NOT NULL,
    totalAmount DECIMAL(15, 2) NOT NULL,
    tblOrder7id INT(10) NOT NULL,
    CONSTRAINT fk_invoice_order7 FOREIGN KEY (tblOrder7id) REFERENCES tblOrder7(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================================
-- DỮ LIỆU MẪU (SEED DATA) PHỤC VỤ KIỂM THỬ 2 MODULE
-- =====================================================================

INSERT INTO tblAddress7 (id, streetAddress, ward, district, city) VALUES
(1, 'Số 18 Mỹ Đình', 'Phường Mỹ Đình 1', 'Nam Từ Liêm', 'Hà Nội'),
(2, 'Số 10 Trần Phú', 'Phường Mộ Lao', 'Hà Đông', 'Hà Nội');

INSERT INTO tblMember7 (id, username, password, firstName, middleName, lastName, email, phone, role, note, tblAddress7id) VALUES
(1, 'binhbv', '123456', 'Bình', 'Văn', 'Bùi', 'pbinhf@gmail.com', '0377035460', 'CUSTOMER', 'Khách hàng thành viên', 1),
(2, 'khonv', '123456', 'Kho', 'Văn', 'Nguyễn', 'khonv@coexmart.vn', '0912345678', 'WAREHOUSE_STAFF', 'Nhân viên thủ kho chính', 2);

INSERT INTO tblCustomer7 (tblMember7id, customerType) VALUES
(1, 'VIP');

INSERT INTO tblEmployee7 (tblMember7id, position, salary) VALUES
(2, 'WarehouseStaff', 15000000.00);

INSERT INTO tblBrand7 (id, name, country, description) VALUES
(1, 'Coex', 'Việt Nam', 'Thương hiệu điện máy chính hãng Coex'),
(2, 'Samsung', 'Hàn Quốc', 'Tập đoàn điện tử Samsung'),
(3, 'Sony', 'Nhật Bản', 'Thương hiệu điện tử Sony'),
(4, 'Panasonic', 'Nhật Bản', 'Thiết bị gia dụng & điện máy Panasonic');

INSERT INTO tblCategory7 (id, name, description) VALUES
(1, 'Tivi', 'Các dòng Smart TV, Google TV, Android TV 4K/FHD'),
(2, 'Tủ lạnh', 'Các dòng tủ lạnh Inverter tiết kiệm điện'),
(3, 'Máy giặt', 'Các dòng máy giặt lồng đứng và lồng ngang');

INSERT INTO tblSpecification7 (id, name, unit) VALUES
(1, 'Kích cỡ màn hình', 'inch'),
(2, 'Độ phân giải', NULL),
(3, 'Hệ điều hành', NULL),
(4, 'Công nghệ hình ảnh', NULL),
(5, 'Cổng kết nối', NULL),
(6, 'Dung tích sử dụng', 'lít'),
(7, 'Công nghệ tiết kiệm điện', NULL),
(8, 'Công nghệ làm lạnh', NULL),
(9, 'Kháng khuẩn khử mùi', NULL),
(10, 'Khối lượng giặt', 'kg'),
(11, 'Động cơ', NULL),
(12, 'Chương trình giặt', NULL);

INSERT INTO tblCategorySpecification7 (id, displayOrder, isRequired, tblSpecification7id, tblCategory7id) VALUES
(1, 1, 1, 1, 1),
(2, 2, 1, 2, 1),
(3, 3, 1, 3, 1),
(4, 4, 0, 4, 1),
(5, 5, 0, 5, 1),
(6, 1, 1, 6, 2),
(7, 2, 1, 7, 2),
(8, 3, 0, 8, 2),
(9, 4, 0, 9, 2),
(10, 1, 1, 10, 3),
(11, 2, 1, 11, 3),
(12, 3, 0, 12, 3);

INSERT INTO tblProduct7 (id, name, modelCode, description, tblBrand7id, tblCategory7id) VALUES
(1, 'Google TV Coex 4K UHD', 'UT7002XG', 'Thiết kế tràn viền 3 cạnh tinh tế, điều khiển tìm kiếm giọng nói bằng tiếng Việt qua trợ lý ảo Google Assistant.', 1, 1),
(2, 'Tủ lạnh Coex 2 cánh Inverter', 'RT-4006IS', 'Vận hành êm ái, bảo quản thực phẩm tươi ngon và tiết kiệm điện năng vượt trội.', 1, 2),
(3, 'Máy giặt lồng đứng Coex', 'TW-9005W', 'Công nghệ giặt xoáy cực mạnh đánh tan mọi vết bẩn cứng đầu.', 1, 3);

INSERT INTO tblVariant7 (id, sku, name, price, warrantyMonths, status, quantity, reservedQuantity, imageUrl, tblProduct7id) VALUES
(1, '65UT7002XG', 'Google TV Coex 4K UHD 65 inch 65UT7002XG', 12990000.00, 24, 'Còn hàng', 5, 0, 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=600', 1),
(2, '50UT7002X', 'Android TV Coex 4K UHD 50 inch 50UT7002X', 12990000.00, 24, 'Còn hàng', 5, 0, 'https://images.unsplash.com/photo-1593784991095-a205069470b6?w=600', 1),
(3, '55UT7002XG', 'Google TV Coex 4K UHD 55 inch 55UT7002XG', 9990000.00, 24, 'Còn hàng', 8, 0, 'https://images.unsplash.com/photo-1577979749830-f1d742b96791?w=600', 1),
(4, '43UT7002X', 'Android TV Coex Full HD 43 inch 43UT7002X', 5990000.00, 24, 'Còn hàng', 12, 0, 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=600', 1),
(5, 'RT-4006IS', 'Tủ lạnh Coex Inverter 198 lít RT-4006IS', 4790000.00, 24, 'Còn hàng', 6, 0, 'https://images.unsplash.com/photo-1584568694244-14fbdf83bd30?w=600', 2),
(6, 'TW-9005W', 'Máy giặt Coex lồng đứng 9.0kg TW-9005W', 4290000.00, 24, 'Còn hàng', 10, 0, 'https://images.unsplash.com/photo-1626806787461-102c1bfaaea1?w=600', 3);

INSERT INTO tblVariantSpecification7 (specValue, tblVariant7id, tblSpecification7id) VALUES
('65 inch', 1, 1),
('4K Ultra HD (3840 x 2160)', 1, 2),
('Google TV', 1, 3),
('HDR10, Chameleon Extreme 2.0', 1, 4),
('3 cổng HDMI, 2 cổng USB, LAN, Wifi', 1, 5),
('50 inch', 2, 1),
('4K Ultra HD (3840 x 2160)', 2, 2),
('Android 11', 2, 3),
('HDR10, Chameleon Extreme 2.0', 2, 4),
('3 cổng HDMI, 2 cổng USB, LAN, Wifi', 2, 5),
('55 inch', 3, 1),
('4K Ultra HD (3840 x 2160)', 3, 2),
('Google TV', 3, 3),
('HDR10, Dolby Audio', 3, 4),
('3 HDMI, 2 USB, Bluetooth 5.0', 3, 5),
('43 inch', 4, 1),
('Full HD (1920 x 1080)', 4, 2),
('Android 11', 4, 3),
('Trochilus Extreme 2.0', 4, 4),
('2 HDMI, 2 USB, Wifi', 4, 5),
('198 lít', 5, 6),
('Smart Inverter', 5, 7),
('Hệ thống làm lạnh đa chiều 360', 5, 8),
('Bộ lọc Nano Titanium', 5, 9),
('9.0 kg', 6, 10),
('Truyền động gián tiếp (Dây Curoa)', 6, 11),
('8 chương trình giặt tiện lợi', 6, 12);
