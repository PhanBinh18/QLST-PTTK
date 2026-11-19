/**
 * HE THONG THONG TIN - COEX MART (B23DCCN087)
 * JAVASCRIPT DIEU KHIEN CAC LOP BIEN (BOUNDARY UI CLASSES)
 * Phù hợp 100% với Sơ đồ lớp chi tiết trong tài liệu 8B23DCCN087(6).docx
 */

// ================= 1. MOCK DATABASE (LOCAL STORAGE) =================
const DEFAULT_PRODUCTS = [
  {
    sku: "65UT7002XG",
    modelCode: "UT7002XG",
    name: "Google TV Coex 4K UHD 65 inch 65UT7002XG",
    productLine: "Google TV Coex 4K UHD",
    category: "Tivi",
    brand: "Coex",
    price: 12990000,
    warrantyMonths: 24,
    status: "Còn hàng",
    stock: 5,
    size: "65 inch",
    sizesAvailable: ["40 inch", "43 inch", "50 inch", "55 inch", "65 inch", "85 inch"],
    image: "https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=600&auto=format&fit=crop&q=80",
    specs: {
      "Kích cỡ màn hình": "65 inch",
      "Độ phân giải": "4K Ultra HD (3840 x 2160)",
      "Hệ điều hành": "Google TV",
      "Công nghệ hình ảnh": "HDR10, Chameleon Extreme 2.0",
      "Cổng kết nối": "3 cổng HDMI, 2 cổng USB, LAN, Wifi"
    },
    description: "Thiết kế tràn viền 3 cạnh tinh tế, điều khiển tìm kiếm giọng nói bằng tiếng Việt qua trợ lý ảo Google Assistant."
  },
  {
    sku: "50UT7002X",
    modelCode: "50UT7002X",
    name: "Android TV Coex 4K UHD 50 inch 50UT7002X",
    productLine: "Android TV Coex 4K UHD",
    category: "Tivi",
    brand: "Coex",
    price: 12990000,
    warrantyMonths: 24,
    status: "Còn hàng",
    stock: 5,
    size: "50 inch",
    sizesAvailable: ["40 inch", "43 inch", "50 inch", "55 inch", "65 inch", "85 inch"],
    image: "https://images.unsplash.com/photo-1593784991095-a205069470b6?w=600&auto=format&fit=crop&q=80",
    specs: {
      "Kích cỡ màn hình": "50 inch",
      "Độ phân giải": "4K Ultra HD (3840 x 2160)",
      "Hệ điều hành": "Android 11",
      "Công nghệ hình ảnh": "HDR10, Bộ xử lý Chameleon Extreme 2.0",
      "Cổng kết nối": "3 cổng HDMI, 2 cổng USB, LAN, Wifi"
    },
    description: "Thiết kế tràn viền 3 cạnh, điều khiển tìm kiếm giọng nói bằng tiếng Việt qua trợ lý ảo Google Assistant."
  },
  {
    sku: "55UT7002XG",
    modelCode: "55UT7002XG",
    name: "Google TV Coex 4K UHD 55 inch 55UT7002XG",
    productLine: "Google TV Coex 4K UHD",
    category: "Tivi",
    brand: "Coex",
    price: 9990000,
    warrantyMonths: 24,
    status: "Còn hàng",
    stock: 8,
    size: "55 inch",
    sizesAvailable: ["40 inch", "43 inch", "50 inch", "55 inch", "65 inch", "85 inch"],
    image: "https://images.unsplash.com/photo-1577979749830-f1d742b96791?w=600&auto=format&fit=crop&q=80",
    specs: {
      "Kích cỡ màn hình": "55 inch",
      "Độ phân giải": "4K Ultra HD (3840 x 2160)",
      "Hệ điều hành": "Google TV",
      "Công nghệ hình ảnh": "HDR10, Dolby Audio",
      "Cổng kết nối": "3 HDMI, 2 USB, Bluetooth 5.0"
    },
    description: "Âm thanh vòm sống động, kho ứng dụng phong phú hàng đầu."
  },
  {
    sku: "43UT7002X",
    modelCode: "43UT7002X",
    name: "Android TV Coex Full HD 43 inch 43UT7002X",
    productLine: "Android TV Coex FHD",
    category: "Tivi",
    brand: "Coex",
    price: 5990000,
    warrantyMonths: 24,
    status: "Còn hàng",
    stock: 12,
    size: "43 inch",
    sizesAvailable: ["40 inch", "43 inch", "50 inch", "55 inch", "65 inch", "85 inch"],
    image: "https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=600&auto=format&fit=crop&q=80",
    specs: {
      "Kích cỡ màn hình": "43 inch",
      "Độ phân giải": "Full HD (1920 x 1080)",
      "Hệ điều hành": "Android 11",
      "Công nghệ hình ảnh": "Trochilus Extreme 2.0",
      "Cổng kết nối": "2 HDMI, 2 USB, Wifi"
    },
    description: "Nhỏ gọn, phù hợp cho phòng ngủ hoặc không gian ấm cúng."
  },
  {
    sku: "RT-4006IS",
    modelCode: "RT-4006IS",
    name: "Tủ lạnh Coex Inverter 198 lít RT-4006IS",
    productLine: "Tủ lạnh Coex 2 cánh Inverter",
    category: "Tủ lạnh",
    brand: "Coex",
    price: 4790000,
    warrantyMonths: 24,
    status: "Còn hàng",
    stock: 6,
    size: "198 lít",
    sizesAvailable: ["185 lít", "198 lít", "256 lít"],
    image: "https://images.unsplash.com/photo-1584568694244-14fbdf83bd30?w=600&auto=format&fit=crop&q=80",
    specs: {
      "Dung tích sử dụng": "198 lít",
      "Công nghệ tiết kiệm điện": "Smart Inverter",
      "Công nghệ làm lạnh": "Hệ thống làm lạnh đa chiều 360",
      "Kháng khuẩn khử mùi": "Bộ lọc Nano Titanium"
    },
    description: "Vận hành êm ái, bảo quản thực phẩm tươi ngon và tiết kiệm điện năng vượt trội."
  },
  {
    sku: "TW-9005W",
    modelCode: "TW-9005W",
    name: "Máy giặt Coex lồng đứng 9.0kg TW-9005W",
    productLine: "Máy giặt lồng đứng Coex",
    category: "Máy giặt",
    brand: "Coex",
    price: 4290000,
    warrantyMonths: 24,
    status: "Còn hàng",
    stock: 10,
    size: "9.0 kg",
    sizesAvailable: ["8.5 kg", "9.0 kg", "10.0 kg"],
    image: "https://images.unsplash.com/photo-1626806787461-102c1bfaaea1?w=600&auto=format&fit=crop&q=80",
    specs: {
      "Khối lượng giặt": "9.0 kg",
      "Động cơ": "Truyền động gián tiếp (Dây Curoa)",
      "Chương trình giặt": "8 chương trình giặt tiện lợi",
      "Mâm giặt": "Mâm giặt kháng khuẩn ion Ag+"
    },
    description: "Công nghệ giặt xoáy cực mạnh đánh tan mọi vết bẩn cứng đầu."
  }
];

const DEFAULT_CART = [
  {
    sku: "50UT7002X",
    name: "Android TV Coex 4K UHD 50 inch 50UT7002X",
    price: 12990000,
    quantity: 1
  },
  {
    sku: "RT-4006IS",
    name: "Tủ lạnh Coex Inverter 198 lít RT-4006IS",
    price: 4790000,
    quantity: 1
  }
];

const DB = {
  getProducts() {
    const data = localStorage.getItem("coex_products_7");
    if (!data) {
      this.setProducts(DEFAULT_PRODUCTS);
      return DEFAULT_PRODUCTS;
    }
    return JSON.parse(data);
  },
  setProducts(products) {
    localStorage.setItem("coex_products_7", JSON.stringify(products));
  },
  getProductBySku(sku) {
    return this.getProducts().find(p => p.sku === sku);
  },
  updateProduct(updated) {
    const products = this.getProducts();
    const index = products.findIndex(p => p.sku === updated.sku);
    if (index !== -1) {
      products[index] = { ...products[index], ...updated };
      this.setProducts(products);
      return true;
    }
    return false;
  },
  updateStock(sku, deltaQuantity) {
    const products = this.getProducts();
    const index = products.findIndex(p => p.sku === sku);
    if (index !== -1) {
      products[index].stock = Math.max(0, products[index].stock - deltaQuantity);
      if (products[index].stock === 0) {
        products[index].status = "Hết hàng";
      }
      this.setProducts(products);
      return true;
    }
    return false;
  },
  getCart() {
    const data = localStorage.getItem("coex_cart_7");
    if (!data) {
      this.setCart(DEFAULT_CART);
      return DEFAULT_CART;
    }
    return JSON.parse(data);
  },
  setCart(cart) {
    localStorage.setItem("coex_cart_7", JSON.stringify(cart));
  },
  clearCart() {
    localStorage.setItem("coex_cart_7", JSON.stringify([]));
  },
  reset() {
    localStorage.removeItem("coex_products_7");
    localStorage.removeItem("coex_cart_7");
    this.setProducts(DEFAULT_PRODUCTS);
    this.setCart(DEFAULT_CART);
  }
};

// ================= 2. APP UI CONTROLLER =================
const AppUI = {
  currentRole: "customer",
  currentView: "CustomerHomeUI7",
  currentSearchKeyword: "Tivi",
  currentSelectedSku: "65UT7002XG",
  lastCreatedOrder: null,

  init() {
    // Check if initial data exists
    if (!localStorage.getItem("coex_products_7")) {
      DB.reset();
    }
    this.showView("CustomerHomeUI7");
  },

  formatMoney(amount) {
    return new Intl.NumberFormat("vi-VN").format(amount) + " đ";
  },

  toast(message, type = "info") {
    const box = document.getElementById("toastBox");
    if (!box) return;
    const msgEl = document.createElement("div");
    msgEl.className = `toast-msg ${type}`;
    let icon = "ℹ️";
    if (type === "success") icon = "✅";
    if (type === "error") icon = "❌";
    msgEl.innerHTML = `<span>${icon}</span><span>${message}</span>`;
    box.appendChild(msgEl);
    setTimeout(() => {
      msgEl.style.opacity = "0";
      msgEl.style.transform = "translateX(100%)";
      setTimeout(() => msgEl.remove(), 250);
    }, 3200);
  },

  showModal(title, desc, onConfirm) {
    const backdrop = document.getElementById("modalBackdrop");
    const titleEl = document.getElementById("modalDialogTitle");
    const descEl = document.getElementById("modalDialogDesc");
    const btnConfirm = document.getElementById("modalBtnConfirm");
    const btnCancel = document.getElementById("modalBtnCancel");

    titleEl.textContent = title;
    descEl.textContent = desc;
    backdrop.classList.add("active");

    const cleanup = () => {
      backdrop.classList.remove("active");
      btnConfirm.onclick = null;
      btnCancel.onclick = null;
    };

    btnConfirm.onclick = () => {
      cleanup();
      if (onConfirm) onConfirm();
    };
    btnCancel.onclick = () => {
      cleanup();
    };
  },

  setRole(role) {
    this.currentRole = role;
    document.getElementById("btnRoleCustomer").classList.toggle("active", role === "customer");
    document.getElementById("btnRoleWarehouse").classList.toggle("active", role === "warehouse");

    if (role === "customer") {
      const av = document.getElementById("headerAvatar"); if (av) av.textContent = "B";
      const un = document.getElementById("headerUserName"); if (un) un.textContent = "Bùi Văn Bình";
      const ur = document.getElementById("headerUserRole"); if (ur) ur.textContent = "Khách hàng thành viên";
      this.showView("CustomerHomeUI7");
    } else {
      const av = document.getElementById("headerAvatar"); if (av) av.textContent = "K";
      const un = document.getElementById("headerUserName"); if (un) un.textContent = "Nguyễn Văn Kho";
      const ur = document.getElementById("headerUserRole"); if (ur) ur.textContent = "Thủ kho (Warehouse Staff)";
      this.showView("WarehouseHomeUI7");
    }
  },


  logout() {
    this.showModal(
      "Đăng xuất khỏi hệ thống",
      "Bạn có chắc muốn kết thúc phiên làm việc hiện tại?",
      () => {
        this.toast("Đã đăng xuất phiên làm việc!", "info");
      }
    );
  },
  showView(viewId) {
    this.currentView = viewId;

    // Update view selector in topbar
    const selector = document.getElementById("viewSelector");
    if (selector) selector.value = viewId;

    // Update current UI indicator
    const indicator = document.getElementById("currentUIIndicator");
    if (indicator) {
      indicator.textContent = `${viewId}`;
    }

    // Toggle views visibility
    document.querySelectorAll(".ui-view").forEach(el => el.classList.remove("active"));
    const target = document.getElementById(viewId);
    if (target) {
      target.classList.add("active");
      window.scrollTo({ top: 0, behavior: "smooth" });
    }

    // Trigger rendering for specific views
    if (viewId === "SearchResultUI7") {
      this.renderSearchResults();
    } else if (viewId === "ItemDetailUI7") {
      this.renderItemDetail();
    } else if (viewId === "CheckoutUI7") {
      this.renderCheckout();
    } else if (viewId === "WarehouseHomeUI7") {
      this.renderWarehouseHome();
    } else if (viewId === "ItemManagementUI7") {
      this.renderItemManagementTable();
    } else if (viewId === "AddItemUI7") {
      this.renderAddCategorySpecs();
    }
  },

  resetDatabase() {
    DB.reset();
    this.toast("Đã khôi phục dữ liệu mẫu ban đầu của đề bài!", "success");
    this.showView(this.currentView);
  },

  // ================= 3. MODULE 1: CUSTOMER VIEWS =================

  // View: CustomerHomeUI7
  handleCustomerSearch() {
    const input = document.getElementById("inKeywordHome");
    const kw = input ? input.value.trim() : "Tivi";
    this.searchWithKeyword(kw || "Tivi");
  },

  searchWithKeyword(kw) {
    this.currentSearchKeyword = kw;
    this.showView("SearchResultUI7");
  },

  // View: SearchResultUI7
  handleResultSearch() {
    const input = document.getElementById("inKeywordResult");
    const kw = input ? input.value.trim() : "";
    if (kw) {
      this.currentSearchKeyword = kw;
      this.renderSearchResults();
    }
  },

  renderSearchResults() {
    const kw = this.currentSearchKeyword || "Tivi";
    const kwHeading = document.getElementById("outKeywordHeading");
    const countText = document.getElementById("outResultCountText");
    const grid = document.getElementById("searchResultGrid");
    const input = document.getElementById("inKeywordResult");

    if (input) input.value = kw;
    if (kwHeading) kwHeading.textContent = `Kết quả tìm kiếm cho: "${kw}"`;

    const products = DB.getProducts();
    const filtered = products.filter(p => {
      const q = kw.toLowerCase();
      return (
        p.name.toLowerCase().includes(q) ||
        p.sku.toLowerCase().includes(q) ||
        p.category.toLowerCase().includes(q) ||
        p.brand.toLowerCase().includes(q)
      );
    });

    if (countText) {
      countText.textContent = `Tìm thấy ${filtered.length} mặt hàng phù hợp với từ khóa`;
    }

    if (!grid) return;
    if (filtered.length === 0) {
      grid.innerHTML = `
        <div style="grid-column: 1 / -1; text-align: center; padding: 48px; background: white; border-radius: 8px; border: 1px dashed var(--border);">
          <div style="font-size: 2.5rem; margin-bottom: 8px;">🔍</div>
          <h3 style="color: var(--text-muted); font-size: 1.1rem;">Không tìm thấy mặt hàng nào phù hợp với từ khóa "${kw}"</h3>
          <p style="font-size: 0.9rem; color: #94a3b8; margin-top: 6px;">Vui lòng thử tìm với từ khóa "Tivi", "Tủ lạnh" hoặc "Coex".</p>
        </div>
      `;
      return;
    }

    grid.innerHTML = filtered.map(item => `
      <div class="product-card">
        <div class="card-img-wrap">
          <img src="${item.image}" alt="${item.name}">
        </div>
        <div class="card-content">
          <div class="card-brand">${item.brand} • ${item.category}</div>
          <div class="card-title" title="${item.name}">${item.name}</div>
          <div class="card-sku">SKU: ${item.sku} | Bảo hành: ${item.warrantyMonths}T</div>
          <div class="card-price">${this.formatMoney(item.price)}</div>
          <div class="card-actions">
            <button class="btn btn-primary btn-sm" style="flex:1;" onclick="AppUI.viewDetail('${item.sku}')">
              Xem chi tiết
            </button>
          </div>
        </div>
      </div>
    `).join("");
  },

  // View: ItemDetailUI7
  viewDetail(sku) {
    this.currentSelectedSku = sku;
    this.showView("ItemDetailUI7");
  },

  renderItemDetail() {
    const item = DB.getProductBySku(this.currentSelectedSku) || DB.getProducts()[0];
    if (!item) return;

    this.currentSelectedSku = item.sku;

    // outProductImage
    const imgEl = document.getElementById("outProductImage");
    if (imgEl) imgEl.src = item.image;

    // outGeneralInfo
    document.getElementById("outBrandName").textContent = `${item.brand} • ${item.category}`;
    document.getElementById("outVariantName").textContent = item.name;
    document.getElementById("outSku").textContent = item.sku;
    document.getElementById("outModelCode").textContent = item.modelCode || item.sku;
    document.getElementById("outPrice").textContent = this.formatMoney(item.price);
    document.getElementById("outWarrantyMonths").textContent = `${item.warrantyMonths} tháng`;
    
    // outStockStatus
    const stockEl = document.getElementById("outStockStatus");
    if (stockEl) {
      if (item.stock > 0) {
        stockEl.className = "badge-status badge-in-stock";
        stockEl.textContent = `Còn hàng (Tồn: ${item.stock})`;
      } else {
        stockEl.className = "badge-status";
        stockEl.style.background = "#fee2e2";
        stockEl.style.color = "#dc2626";
        stockEl.textContent = "Hết hàng";
      }
    }

    // subChooseSize
    const sizeGroup = document.getElementById("outSizeOptionsGroup");
    if (sizeGroup) {
      const sizes = item.sizesAvailable || [item.size];
      sizeGroup.innerHTML = sizes.map(sz => `
        <button class="size-pill-btn ${sz === item.size ? 'active' : ''}" onclick="AppUI.chooseSize('${sz}')">
          ${sz}
        </button>
      `).join("");
    }

    // outSpecifications
    const specsTable = document.getElementById("outSpecsTable");
    if (specsTable) {
      const specs = item.specs || { "Đặc tính": "Chính hãng", "Bảo hành": `${item.warrantyMonths} tháng` };
      specsTable.innerHTML = Object.entries(specs).map(([k, v]) => `
        <tr>
          <td>${k}</td>
          <td>${v}</td>
        </tr>
      `).join("");
    }

    // outHighlightDescription
    const descEl = document.getElementById("outHighlightDescription");
    if (descEl) descEl.textContent = item.description || "Sản phẩm chính hãng với bảo hành toàn diện.";

    // Cart count button
    const cart = DB.getCart();
    const count = cart.reduce((sum, i) => sum + i.quantity, 0);
    const cartCountText = document.getElementById("cartCountBtnText");
    if (cartCountText) cartCountText.textContent = count;
  },

  chooseSize(sizeStr) {
    const products = DB.getProducts();
    const current = DB.getProductBySku(this.currentSelectedSku);
    if (!current) return;

    // Find related variant with this size in same product line/category
    const related = products.find(p => p.category === current.category && p.brand === current.brand && p.size === sizeStr);
    if (related) {
      this.currentSelectedSku = related.sku;
      this.renderItemDetail();
      this.toast(`Đã chọn kích thước ${sizeStr} (${related.sku})`, "info");
    } else {
      this.toast(`Đã cập nhật tùy chọn kích thước ${sizeStr}`, "info");
    }
  },

  addToCartFromDetail() {
    const item = DB.getProductBySku(this.currentSelectedSku);
    if (!item) return;

    if (item.stock <= 0) {
      this.toast("Mặt hàng này hiện đã hết hàng trong kho!", "error");
      return;
    }

    const cart = DB.getCart();
    const existing = cart.find(i => i.sku === item.sku);

    if (existing) {
      if (existing.quantity >= item.stock) {
        this.toast(`Số lượng trong giỏ (${existing.quantity}) đã đạt mức tồn kho tối đa!`, "error");
        return;
      }
      existing.quantity += 1;
    } else {
      cart.push({
        sku: item.sku,
        name: item.name,
        price: item.price,
        quantity: 1
      });
    }

    DB.setCart(cart);
    this.toast(`Đã thêm 1 "${item.name}" vào giỏ hàng!`, "success");
    this.renderItemDetail();
  },

  // View: CheckoutUI7
  renderCheckout() {
    const cart = DB.getCart();
    const tbody = document.getElementById("cartTableBody");
    const countBadge = document.getElementById("outItemCountBadge");
    const subtotalEl = document.getElementById("costSubtotal");
    const totalEl = document.getElementById("costTotalAmount");

    const totalItems = cart.reduce((sum, i) => sum + i.quantity, 0);
    if (countBadge) countBadge.textContent = `${totalItems} món`;

    if (!tbody) return;

    if (cart.length === 0) {
      tbody.innerHTML = `
        <tr>
          <td colspan="5" style="text-align: center; padding: 36px; color: var(--text-muted);">
            Giỏ hàng của bạn đang trống. Vui lòng quay lại chọn mặt hàng.
          </td>
        </tr>
      `;
      if (subtotalEl) subtotalEl.textContent = "0 đ";
      if (totalEl) totalEl.textContent = "100.000 đ";
      return;
    }

    let subtotal = 0;
    tbody.innerHTML = cart.map(item => {
      const lineTotal = item.price * item.quantity;
      subtotal += lineTotal;
      return `
        <tr>
          <td>
            <div class="cart-item-title">${item.name}</div>
            <div class="cart-item-sku">SKU: ${item.sku}</div>
          </td>
          <td style="font-weight: 600;">${this.formatMoney(item.price)}</td>
          <td style="text-align: center;">
            <div class="qty-controller">
              <button class="qty-btn" onclick="AppUI.decreaseQty('${item.sku}')">-</button>
              <input type="text" class="qty-input" value="${item.quantity}" readonly>
              <button class="qty-btn" onclick="AppUI.increaseQty('${item.sku}')">+</button>
            </div>
          </td>
          <td style="text-align: right; font-weight: 700; color: #dc2626;">${this.formatMoney(lineTotal)}</td>
          <td style="text-align: center;">
            <button class="btn btn-secondary btn-sm" style="color: #dc2626;" onclick="AppUI.removeItem('${item.sku}')" title="Xóa mặt hàng">
              🗑️
            </button>
          </td>
        </tr>
      `;
    }).join("");

    const shippingFee = 100000;
    const grandTotal = subtotal + shippingFee;
    if (subtotalEl) subtotalEl.textContent = this.formatMoney(subtotal);
    if (totalEl) totalEl.textContent = this.formatMoney(grandTotal);
  },

  increaseQty(sku) {
    const cart = DB.getCart();
    const item = cart.find(i => i.sku === sku);
    const prod = DB.getProductBySku(sku);

    if (item && prod) {
      if (item.quantity >= prod.stock) {
        this.toast(`Mặt hàng ${sku} chỉ còn ${prod.stock} chiếc trong kho!`, "error");
        return;
      }
      item.quantity += 1;
      DB.setCart(cart);
      this.renderCheckout();
    }
  },

  decreaseQty(sku) {
    const cart = DB.getCart();
    const item = cart.find(i => i.sku === sku);
    if (item) {
      if (item.quantity > 1) {
        item.quantity -= 1;
        DB.setCart(cart);
        this.renderCheckout();
      } else {
        this.removeItem(sku);
      }
    }
  },

  removeItem(sku) {
    let cart = DB.getCart();
    cart = cart.filter(i => i.sku !== sku);
    DB.setCart(cart);
    this.toast(`Đã bỏ mặt hàng ${sku} khỏi giỏ hàng`, "info");
    this.renderCheckout();
  },

  handleSubmitOrder() {
    const cart = DB.getCart();
    if (cart.length === 0) {
      this.toast("Giỏ hàng của bạn đang trống! Vui lòng chọn sản phẩm trước.", "error");
      return;
    }

    // Validate inputs
    const name = document.getElementById("inReceiverName").value.trim();
    const phone = document.getElementById("inReceiverPhone").value.trim();
    const email = document.getElementById("inReceiverEmail").value.trim();
    const province = document.getElementById("inProvince").value.trim();
    const district = document.getElementById("inDistrict").value.trim();
    const address = document.getElementById("inAddressDetail").value.trim();
    const note = document.getElementById("inDeliveryNote").value.trim();

    let valid = true;

    if (!name) {
      document.getElementById("errReceiverName").classList.add("visible");
      valid = false;
    } else {
      document.getElementById("errReceiverName").classList.remove("visible");
    }

    if (!phone || phone.length < 9) {
      document.getElementById("errReceiverPhone").classList.add("visible");
      valid = false;
    } else {
      document.getElementById("errReceiverPhone").classList.remove("visible");
    }

    if (!address) {
      document.getElementById("errAddressDetail").classList.add("visible");
      valid = false;
    } else {
      document.getElementById("errAddressDetail").classList.remove("visible");
    }

    if (!valid) {
      this.toast("Vui lòng điền đầy đủ các trường thông tin bắt buộc!", "error");
      return;
    }

    // Step 47-49: InventoryDAO7 check stock availability
    for (const item of cart) {
      const prod = DB.getProductBySku(item.sku);
      if (!prod || prod.stock < item.quantity) {
        this.toast(`Mặt hàng "${item.name}" không đủ số lượng tồn kho khả dụng!`, "error");
        return;
      }
    }

    // Step 53-55: OrderDAO7 create order
    const subtotal = cart.reduce((sum, i) => sum + i.price * i.quantity, 0);
    const shippingFee = 100000;
    const totalAmount = subtotal + shippingFee;

    const newOrder = {
      orderCode: "DH087",
      status: "Chờ duyệt",
      createdAt: new Date().toLocaleString("vi-VN"),
      customer: {
        name,
        phone,
        email,
        address: `${address}, ${district}, ${province}`
      },
      note,
      items: [...cart],
      subtotal,
      shippingFee,
      totalAmount
    };

    // Step 56-58: InventoryDAO7 update stock availability (deduct stock)
    for (const item of cart) {
      DB.updateStock(item.sku, item.quantity);
    }

    // Save created order
    this.lastCreatedOrder = newOrder;

    // Step 59: Clear cart
    DB.clearCart();

    // Step 60: Call OrderConfirmationUI7
    this.renderOrderConfirmation(newOrder);
    this.showView("OrderConfirmationUI7");
    this.toast("Đặt hàng thành công! Đơn hàng đã được lưu vào hệ thống.", "success");
  },

  // View: OrderConfirmationUI7
  renderOrderConfirmation(order) {
    const o = order || this.lastCreatedOrder || {
      orderCode: "DH087",
      status: "Chờ duyệt",
      items: DEFAULT_CART,
      subtotal: 17780000,
      shippingFee: 100000,
      totalAmount: 17880000,
      customer: {
        name: "Bùi Văn Bình",
        phone: "0377035460",
        email: "pbinhf@gmail.com",
        address: "Mỹ Đình, Phường Mỹ Đình 1, Nam Từ Liêm, Hà Nội"
      },
      note: "Giao giờ hành chính, gọi điện trước"
    };

    document.getElementById("outOrderCode").textContent = o.orderCode;
    document.getElementById("outOrderStatus").textContent = o.status;
    document.getElementById("confirmSubtotal").textContent = this.formatMoney(o.subtotal);
    document.getElementById("confirmShippingFee").textContent = this.formatMoney(o.shippingFee);
    document.getElementById("confirmTotalAmount").textContent = this.formatMoney(o.totalAmount);

    const tbody = document.getElementById("confirmOrderItemsTable");
    if (tbody) {
      tbody.innerHTML = o.items.map(item => `
        <tr>
          <td>
            <strong>${item.name}</strong>
            <div style="font-size:0.75rem; font-family:monospace; color:var(--text-muted);">SKU: ${item.sku}</div>
          </td>
          <td style="text-align: center;">${item.quantity}</td>
          <td style="text-align: right;">${this.formatMoney(item.price)}</td>
          <td style="text-align: right; font-weight: 700;">${this.formatMoney(item.price * item.quantity)}</td>
        </tr>
      `).join("");
    }

    const recEl = document.getElementById("outReceiverInfoText");
    if (recEl) {
      recEl.innerHTML = `
        <div>Họ và tên người nhận: <strong>${o.customer.name}</strong></div>
        <div>Số điện thoại liên hệ: <strong>${o.customer.phone}</strong></div>
        <div>Email: <span>${o.customer.email || 'Không có'}</span></div>
        <div>Địa chỉ nhận hàng: <strong>${o.customer.address}</strong></div>
        <div>Ghi chú giao hàng: <em>${o.note || 'Không có'}</em></div>
      `;
    }
  },

  // ================= 4. MODULE 2: WAREHOUSE VIEWS =================

  // View: WarehouseHomeUI7
  renderWarehouseHome() {
    const products = DB.getProducts();
    const totalItems = products.length;
    const totalStock = products.reduce((sum, p) => sum + p.stock, 0);

    const kpiItem = document.getElementById("kpiItemCount");
    const kpiStock = document.getElementById("kpiStockCount");
    if (kpiItem) kpiItem.textContent = totalItems;
    if (kpiStock) kpiStock.textContent = totalStock;
  },

  // View: ItemManagementUI7
  resetItemFilters() {
    document.getElementById("inSearchName").value = "";
    document.getElementById("inCategoryFilter").value = "Tất cả";
    document.getElementById("inBrandFilter").value = "Tất cả";
    document.getElementById("inStatusFilter").value = "Tất cả";
    this.renderItemManagementTable();
  },

  renderItemManagementTable() {
    const searchVal = (document.getElementById("inSearchName")?.value || "").trim().toLowerCase();
    const catVal = document.getElementById("inCategoryFilter")?.value || "Tất cả";
    const brandVal = document.getElementById("inBrandFilter")?.value || "Tất cả";
    const statusVal = document.getElementById("inStatusFilter")?.value || "Tất cả";

    const products = DB.getProducts();

    const filtered = products.filter(p => {
      const matchSearch = !searchVal || p.name.toLowerCase().includes(searchVal) || p.sku.toLowerCase().includes(searchVal);
      const matchCat = catVal === "Tất cả" || p.category === catVal;
      const matchBrand = brandVal === "Tất cả" || p.brand === brandVal;
      const matchStatus = statusVal === "Tất cả" || p.status === statusVal;
      return matchSearch && matchCat && matchBrand && matchStatus;
    });

    const countText = document.getElementById("outItemCountText");
    if (countText) countText.textContent = `${filtered.length} mặt hàng`;

    const tbody = document.getElementById("itemManagementTableBody");
    if (!tbody) return;

    if (filtered.length === 0) {
      tbody.innerHTML = `
        <tr>
          <td colspan="9" style="text-align: center; padding: 32px; color: var(--text-muted);">
            ⚠️ Không tìm thấy mặt hàng nào phù hợp với bộ lọc hiện tại.
          </td>
        </tr>
      `;
      return;
    }

    tbody.innerHTML = filtered.map((item, idx) => `
      <tr>
        <td style="text-align: center; color: var(--text-muted);">${idx + 1}</td>
        <td style="font-family: monospace; font-weight: 700; color: var(--primary);">${item.sku}</td>
        <td>
          <div style="font-weight: 600;">${item.name}</div>
          <div style="font-size: 0.75rem; color: var(--text-muted);">Model: ${item.modelCode || item.sku} | Tồn kho: ${item.stock}</div>
        </td>
        <td>${item.category}</td>
        <td>${item.brand}</td>
        <td style="font-weight: 700; color: #dc2626;">${this.formatMoney(item.price)}</td>
        <td>${item.warrantyMonths} tháng</td>
        <td>
          <span class="badge-status ${item.status === 'Còn hàng' ? 'badge-in-stock' : ''}" style="${item.status !== 'Còn hàng' ? 'background:#fee2e2; color:#dc2626;' : ''}">
            ${item.status}
          </span>
        </td>
        <td style="text-align: center;">
          <button class="btn btn-primary btn-sm" onclick="AppUI.editItem('${item.sku}')">
            Sửa
          </button>
        </td>
      </tr>
    `).join("");
  },

  // View: EditItemUI7
  editItem(sku) {
    const item = DB.getProductBySku(sku);
    if (!item) return;

    this.currentSelectedSku = sku;
    this.showView("EditItemUI7");

    // outSku
    document.getElementById("editOutSku").textContent = item.sku;
    document.getElementById("editProductName").value = item.productLine || item.name;
    document.getElementById("editModelCode").value = item.modelCode || item.sku;
    document.getElementById("editDescription").value = item.description || "Mô tả dòng sản phẩm";

    // inoutSpecifications (editable input fields)
    const specsTable = document.getElementById("editSpecsTable");
    if (specsTable) {
      const specs = item.specs || { "Đặc tính": "Chính hãng", "Bảo hành": `${item.warrantyMonths} tháng` };
      specsTable.innerHTML = Object.entries(specs).map(([k, v]) => `
        <tr>
          <td style="width: 35%; font-weight: 600;">${k}</td>
          <td>
            <input type="text" class="form-control edit-spec-input" data-spec-key="${k}" value="${v}">
          </td>
        </tr>
      `).join("");
    }

    // Editable variant fields
    document.getElementById("editVariantName").value = item.name;
    document.getElementById("editPrice").value = item.price;
    document.getElementById("editWarrantyMonths").value = item.warrantyMonths;
    document.getElementById("editStatus").value = item.status;

    // Reset errors
    document.getElementById("errEditPrice").classList.remove("visible");
    document.getElementById("errEditWarranty").classList.remove("visible");
  },

  saveEditItem() {
    const item = DB.getProductBySku(this.currentSelectedSku);
    if (!item) return;

    const productLine = document.getElementById("editProductName").value.trim();
    const modelCode = document.getElementById("editModelCode").value.trim();
    const description = document.getElementById("editDescription").value.trim();
    const variantName = document.getElementById("editVariantName").value.trim();
    const priceVal = parseFloat(document.getElementById("editPrice").value);
    const warrantyVal = parseInt(document.getElementById("editWarrantyMonths").value, 10);
    const statusVal = document.getElementById("editStatus").value;

    const updatedSpecs = {};
    document.querySelectorAll(".edit-spec-input").forEach(inp => {
      const key = inp.getAttribute("data-spec-key");
      if (key) updatedSpecs[key] = inp.value.trim();
    });

    let valid = true;

    if (isNaN(priceVal) || priceVal <= 0) {
      document.getElementById("errEditPrice").classList.add("visible");
      valid = false;
    } else {
      document.getElementById("errEditPrice").classList.remove("visible");
    }

    if (isNaN(warrantyVal) || warrantyVal <= 0) {
      document.getElementById("errEditWarranty").classList.add("visible");
      valid = false;
    } else {
      document.getElementById("errEditWarranty").classList.remove("visible");
    }

    if (!valid) {
      this.toast("Dữ liệu nhập vào chưa hợp lệ, vui lòng kiểm tra lại!", "error");
      return;
    }

    // Update in database (ProductDAO7.updateProduct & VariantDAO7.updateVariant)
    DB.updateProduct({
      sku: item.sku,
      productLine: productLine || item.productLine,
      modelCode: modelCode || item.modelCode,
      description: description || item.description,
      name: variantName || item.name,
      price: priceVal,
      warrantyMonths: warrantyVal,
      status: statusVal,
      specs: Object.keys(updatedSpecs).length > 0 ? updatedSpecs : item.specs
    });

    this.toast(`Lưu thay đổi thành công cho mặt hàng ${item.sku}!`, "success");
    this.showView("ItemManagementUI7");
  },

  cancelEditItem() {
    this.showModal(
      "Xác nhận hủy bỏ",
      "Mọi thay đổi chưa lưu sẽ bị hủy bỏ. Bạn có chắc chắn muốn quay về danh sách quản lý mặt hàng?",
      () => {
        this.showView("ItemManagementUI7");
      }
    );
  },

  // View: AddItemUI7 (Thêm mặt hàng mới)
  openAddItem() {
    this.showView("AddItemUI7");
    this.renderAddCategorySpecs();
  },

  renderAddCategorySpecs() {
    const cat = document.getElementById("addCategory")?.value || "Tivi";
    const specsByCat = {
      "Tivi": ["Kích cỡ màn hình", "Độ phân giải", "Hệ điều hành", "Công nghệ hình ảnh", "Cổng kết nối"],
      "Tủ lạnh": ["Dung tích sử dụng", "Công nghệ tiết kiệm điện", "Công nghệ làm lạnh", "Kháng khuẩn khử mùi"],
      "Máy giặt": ["Khối lượng giặt", "Động cơ", "Chương trình giặt"]
    };
    const specNames = specsByCat[cat] || specsByCat["Tivi"];
    const table = document.getElementById("addSpecsTable");
    if (!table) return;
    table.innerHTML = specNames.map((k, idx) => `
      <tr>
        <td style="width: 35%; font-weight: 600;">${idx + 1}. ${k}</td>
        <td>
          <input type="text" class="form-control add-spec-input" data-spec-key="${k}" placeholder="Nhập ${k.toLowerCase()}...">
        </td>
      </tr>
    `).join("");
  },

  saveNewItem() {
    const category = document.getElementById("addCategory").value;
    const brand = document.getElementById("addBrand").value;
    const productLine = document.getElementById("addProductName").value.trim();
    const modelCode = document.getElementById("addModelCode").value.trim();
    const description = document.getElementById("addDescription").value.trim();
    const sku = document.getElementById("addSku").value.trim();
    const name = document.getElementById("addVariantName").value.trim();
    const price = parseFloat(document.getElementById("addPrice").value);
    const warrantyMonths = parseInt(document.getElementById("addWarrantyMonths").value, 10);
    const stock = parseInt(document.getElementById("addStock").value, 10) || 0;
    const status = document.getElementById("addStatus").value;

    if (!sku || !name || !productLine) {
      this.toast("Vui lòng nhập đầy đủ Mã SKU, Tên mặt hàng và Tên dòng sản phẩm!", "error");
      return;
    }
    if (isNaN(price) || price <= 0 || isNaN(warrantyMonths) || warrantyMonths <= 0) {
      this.toast("Đơn giá niêm yết và Thời gian bảo hành phải lớn hơn 0!", "error");
      return;
    }
    if (DB.getProductBySku(sku)) {
      this.toast(`Mã SKU "${sku}" đã tồn tại trong kho!`, "error");
      return;
    }

    const specs = {};
    document.querySelectorAll(".add-spec-input").forEach(inp => {
      const key = inp.getAttribute("data-spec-key");
      if (key) specs[key] = inp.value.trim() || "Tiêu chuẩn chính hãng";
    });

    const products = DB.getProducts();
    products.push({
      sku,
      modelCode: modelCode || sku,
      name,
      productLine,
      category,
      brand,
      price,
      warrantyMonths,
      status,
      stock: Math.max(0, stock),
      size: specs["Kích cỡ màn hình"] || specs["Dung tích sử dụng"] || specs["Khối lượng giặt"] || "Tiêu chuẩn",
      sizesAvailable: [specs["Kích cỡ màn hình"] || "Tiêu chuẩn"],
      image: "https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=600&auto=format&fit=crop&q=80",
      specs,
      description: description || "Sản phẩm điện máy chính hãng bảo hành toàn quốc."
    });
    DB.setProducts(products);

    this.toast(`Thêm mặt hàng mới "${name}" (${sku}) thành công!`, "success");
    this.showView("ItemManagementUI7");
  }
};

// Auto start when DOM is ready
document.addEventListener("DOMContentLoaded", () => {
  AppUI.init();
});
