# HỆ THỐNG THÔNG TIN - THIẾT KẾ GIAO DIỆN & MÔ PHỎNG KỊCH BẢN (MÃ SV: B23DCCN087)

Dự án thiết kế giao diện hoàn chỉnh bằng **HTML, CSS, JavaScript thuần (Vanilla JS)** không phụ thuộc thư viện ngoài, chạy trực tiếp trên mọi trình duyệt web (offline & online). Dữ liệu mẫu (Mock data) được đồng bộ giữa hai phân hệ Khách hàng và Thủ kho thông qua `LocalStorage`.

---

## 📌 1. BẢNG ÁNH XẠ CÁC LỚP BIÊN (BOUNDARY UI CLASSES) THEO THIẾT KẾ PHÂN TÍCH

| Phân hệ | Tên lớp biên (UI) | Thành phần đầu vào / đầu ra / sự kiện | Mô tả chức năng |
| :--- | :--- | :--- | :--- |
| **Khách hàng (Customer)** | `CustomerHomeUI7` | `inKeyword`, `subSearch` | Trang chủ tìm kiếm sản phẩm điện máy, banner, danh mục nhanh. |
| | `SearchResultUI7` | `outsubItemList` | Hiển thị kết quả tìm kiếm dạng lưới thẻ (tối đa 20 thẻ/trang). Xử lý ngoại lệ không tìm thấy. |
| | `ItemDetailUI7` | `outGeneralInfo`, `outsubSizeOptions`, `outSpecifications`, `outHighlightDescription`, `subBuyNow` | Chi tiết mặt hàng (ảnh, giá bán, SKU, bảo hành, kích cỡ, bảng thông số kỹ thuật, mô tả nổi bật, mua ngay). |
| | `CheckoutUI7` | `outCartItems`, `inoutQuantity`, `outCostSummary`, `inReceiverInfo`, `inShippingAddress`, `subSubmitOrder` | Giỏ hàng & đặt hàng (tăng giảm số lượng, tính tiền ship, form thông tin người nhận, validate lỗi). |
| | `OrderConfirmationUI7` | `outSuccessStatus`, `outOrderDetail`, `subViewOrderHistory`, `subContinueShopping` | Xác nhận đặt hàng thành công, hiển thị mã đơn `DH087`, trạng thái `Chờ duyệt`, chi tiết thanh toán. |
| **Thủ kho (Warehouse Staff)** | `WarehouseHomeUI7` | `subManageItem` | Trang chủ điều khiển kho, thẻ KPI tổng quan (mặt hàng, tồn kho, đơn chờ duyệt). |
| | `ItemManagementUI7` | `inSearchSku`, `inCategoryFilter`, `inBrandFilter`, `inStatusFilter`, `subSearch`, `subReset`, `subAddNewItem`, `outsubItemList` | Bảng danh sách quản lý mặt hàng, tìm kiếm theo SKU, lọc danh mục/hãng/trạng thái. Nút thao tác [Xem], [Sửa], [Xóa]. |
| | `EditItemUI7` | `outProductInfo`, `outVariantInfo`, `outSpecifications`, `outDescription`, `inoutPrice`, `inoutWarrantyMonths`, `subSave`, `subCancel` | Form chỉnh sửa đơn giá niêm yết và thời hạn bảo hành. Validate dữ liệu > 0, popup xác nhận hủy. |

---

## 🚀 2. HƯỚNG DẪN TEST CÁC KỊCH BẢN THEO ĐỀ BÀI

### A. Kịch bản 1: Đặt hàng trực tuyến (`Order Online 7`)
1. **Tại thanh trên cùng**: Chọn vai trò **👤 Khách hàng (Module 1)**.
2. **Tìm kiếm**: Nhập từ khóa `Tivi` vào thanh tìm kiếm ở đầu trang và nhấn **Enter** hoặc bấm nút **Tìm kiếm**.
3. **Danh sách kết quả**: Màn hình `SearchResultUI7` hiển thị các thẻ tivi (Google TV Coex 65 inch, 55 inch, Android TV 50 inch, 43 inch...).
4. **Xem chi tiết**: Bấm vào thẻ **Android TV Coex 4K UHD 50 inch 50UT7002X** (hoặc Coex 65 inch):
   - Màn hình `ItemDetailUI7` hiển thị đầy đủ Model, SKU: 709644, giá bán 12.990.000 đ, bảo hành 24 tháng, bảng thông số kỹ thuật, các nút kích thước: 40 | 43 | [50 inch (Đang chọn)] | 55 | 65 | 85 inch.
5. **Thêm giỏ hàng**: Bấm nút **"Thêm vào giỏ hàng"** (hiển thị thông báo thành công).
6. **Thêm sản phẩm thứ hai**: Tìm từ khóa `Tủ lạnh`, bấm vào mặt hàng **Tủ lạnh Coex Inverter 198 lít RT-4006IS**, bấm **"Thêm vào giỏ hàng"**.
7. **Vào giỏ hàng**: Bấm biểu tượng 🛒 ở góc trên bên phải màn hình để mở `CheckoutUI7`.
8. **Kiểm tra giỏ hàng**:
   - Thấy đủ 2 sản phẩm: Tivi (12.990.000 đ) và Tủ lạnh (4.790.000 đ).
   - Tăng/giảm số lượng: Thử bấm `+` vượt quá số lượng tồn kho khả dụng (tối đa 5-6 chiếc) -> Hệ thống báo lỗi: *"Số lượng sản phẩm đã đến mức tối đa"*.
   - Kiểm tra tổng kết chi phí: Tạm tính 17.780.000 đ + Vận chuyển 100.000 đ = **17.880.000 đ**.
   - Kiểm tra validate: Xóa trống ô địa chỉ cụ thể hoặc nhập số điện thoại không đủ 10 số -> Hệ thống báo lỗi đỏ: *"Vui lòng nhập địa chỉ cụ thể"*, *"Số điện thoại không hợp lệ"*.
9. **Đặt hàng**: Bấm nút **"🛍️ Đặt hàng ngay"**:
   - Màn hình `OrderConfirmationUI7` hiển thị biểu tượng tích xanh: **"Đặt hàng thành công!"**.
   - Mã đơn hàng: **DH087**, trạng thái: **Chờ duyệt**.

---

### B. Kịch bản 2: Sửa thông tin mặt hàng (`Edit Item Info 7`)
1. **Tại thanh trên cùng**: Bấm nút **📦 Thủ Kho (Module 2)**.
2. **Trang chủ kho**: Màn hình `WarehouseHomeUI7` hiển thị bảng điều khiển. Bấm nút **"⚙️ Quản lý mặt hàng"**.
3. **Màn hình Quản lý mặt hàng (`ItemManagementUI7`)**:
   - Nhập mã SKU `65UT7002XG` vào ô tìm kiếm theo mã và bấm **Tìm kiếm** (hoặc Enter).
   - Bảng danh sách lọc chính xác dòng mặt hàng **Google TV Coex 4K UHD 65 inch**.
   - Thử nhập mã không tồn tại (vd: `XYZ999`) -> Bảng hiển thị thông báo: *"⚠️ Không tìm thấy mặt hàng"*.
4. **Chỉnh sửa**: Bấm nút **[Sửa]** trên dòng `65UT7002XG`:
   - Màn hình `EditItemUI7` mở ra với các trường phân loại và mô tả cố định.
   - Các trường cho phép sửa: **Đơn giá niêm yết** và **Thời gian bảo hành**.
   - Thử nghiệm validate lỗi: Xóa trắng đơn giá hoặc nhập `-1000` -> Báo lỗi đỏ *"Đơn giá phải là số lớn hơn 0"*.
   - Thử nghiệm hủy: Bấm nút **[Hủy]** -> Popup xác nhận: *"Mọi thay đổi sẽ không được lưu"*. Bấm Đóng để tiếp tục sửa.
5. **Lưu cập nhật**:
   - Sửa **Đơn giá** từ `12.990.000` thành `11.490.000`.
   - Sửa **Thời gian bảo hành** từ `24` thành `36`.
   - Bấm nút **"💾 Lưu thay đổi"**.
   - Hệ thống hiển thị thông báo: **"Lưu thành công"** và quay trở về bảng danh sách `ItemManagementUI7` với đơn giá mới đã được cập nhật ngay lập tức!
6. **Kiểm tra tính đồng bộ**: Bấm chuyển sang vai trò **👤 Khách hàng (Module 1)**, tìm Tivi `65UT7002XG` -> Giá bán và bảo hành phía khách hàng cũng được cập nhật sang **11.490.000 đ** và **36 tháng** một cách đồng bộ!

---

## 🛠️ 3. CÁCH KHỞI CHẠY GIAO DIỆN
- Chỉ cần nhấp đúp chuột mở file **`index.html`** bằng trình duyệt web bất kỳ (Google Chrome, Microsoft Edge, Firefox, Cốc Cốc, Safari...).
- Không cần cài đặt Node.js hay web server phức tạp.
- Khi muốn đưa dữ liệu về trạng thái mẫu ban đầu của bài tập, bấm nút **🔄 Reset Data** ở góc trên cùng bên phải.
