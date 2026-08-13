-- ==============================================
-- MENU TAB ĐA NĂNG | SỬA LỖI HIỆN MENU HOÀN HẢO
-- Tương thích Mobile+PC | Bong bóng ảnh + Viền đẹp
-- Tác giả: HC Roblox | Chỉ dùng game tự tạo
-- ==============================================

-- Dịch vụ
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui", 10)
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ======================
-- ⚙️ CÀI ĐẶT CHUNG
-- ======================
local CaiDat = {
    -- Thông số chức năng
    SpeedChay = 80,
    JumpCao = 150,
    SpeedFly = 95,
    SpeedBayNhanh = 180,
    KhoangCao = 120,
    -- Phím tắt PC
    Key_Menu = Enum.KeyCode.F4,
    -- Icon
    Icon_DiChuyen = "🏃", Icon_HienThi = "👁️", Icon_NhanVat = "👤", Icon_Them = "⚙️",
    Icon_Fly = "✈️", Icon_TangToc = "⚡", Icon_NhayCao = "⬆️", Icon_TangHinh = "👻",
    Icon_ESP = "🔴", Icon_XemQuaTuong = "🔍", Icon_LuonSang = "💡", Icon_KhongRoi = "🛡️",
    Icon_BatTu = "❤️", Icon_CucNhanh = "💨", Icon_BayCao = "☁️", Icon_DayManh = "💪",
    Icon_GiamToc = "🐢", Icon_ChatMau = "🎨", Icon_KhongMatNen = "🚫", Icon_ThuGon = "➖",
    -- Tác giả
    TenTacGia = "HC Roblox",
    -- Màu sắc UI
    Mau_Nen = Color3.fromRGB(18, 20, 28),
    Mau_Nen_Sang = Color3.fromRGB(35, 40, 60),
    Mau_Tab_Chon = Color3.fromRGB(60, 130, 255),
    Mau_Xanh = Color3.fromRGB(72, 207, 120),
    Mau_Do = Color3.fromRGB(231, 76, 60),
    Mau_Vien = Color3.fromRGB(120, 180, 255),
    Mau_Chu = Color3.new(1,1,1),
    Mau_BongBong = Color3.fromRGB(60, 140, 255),
    -- Kích thước
    KichThuoc_Menu = UDim2.new(0, 310, 0, 330),
    KichThuoc_BongBong = UDim2.new(0, 58, 0, 58),
    KichThuoc_Nut = UDim2.new(1, -10, 0, 44),
    -- Ảnh bong bóng
    Link_AnhBongBong = "rbxassetid://6023426935",
}

-- Trạng thái
local TrangThai = {
    -- Di chuyển
    TangToc = false, GiamToc = false, NhayCao = false, Fly = false, BayNhanh = false, BayCao = false,
    -- Hiển thị
    ESP = false, XemQuaTuong = false, LuonSang = false, TangHinh = false, ChatMau = false,
    -- Nhân vật
    KhongRoi = false, BatTu = false, VoCuc = false, KhongMatNen = false,
    -- Khác
    MenuDangMo = true, TabHienTai = 1,
}
local BodyVelocity, BodyGyro
local Character, Humanoid, RootPart
local ESPs = {}
local AnhSang = nil

-- ======================
-- 🧩 TẠO UI CHẮC CHẮN KHÔNG BỊ LỖI
-- ======================
local function TaoUI()
    -- Kiểm tra PlayerGui
    if not PlayerGui then warn("❌ Không tìm thấy PlayerGui!") return nil end

    -- Xóa giao diện cũ nếu có tránh trùng
    local Cu = PlayerGui:FindFirstChild("MenuTab_HCRoblox")
    if Cu then Cu:Destroy() end

    -- Tạo giao diện chính
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MenuTab_HCRoblox"
    ScreenGui.Parent = PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Enabled = true -- Bật hiển thị ngay

    -- ===== KHUNG MENU CHÍNH =====
    local MenuChinh = Instance.new("Frame")
    MenuChinh.Name = "MenuChinh"
    MenuChinh.Size = CaiDat.KichThuoc_Menu
    MenuChinh.Position = UDim2.new(0.05, 0, 0.12, 0)
    MenuChinh.BackgroundColor3 = CaiDat.Mau_Nen
    MenuChinh.BorderSizePixel = 0
    MenuChinh.Visible = true
    MenuChinh.Active = true
    MenuChinh.Draggable = true -- Kéo được
    MenuChinh.Parent = ScreenGui
    Instance.new("UICorner", MenuChinh).CornerRadius = UDim.new(0,14)
    -- Viền đẹp
    local VienMenu = Instance.new("UIStroke")
    VienMenu.Color = CaiDat.Mau_Vien
    VienMenu.Thickness = 2.2
    VienMenu.Transparency = 0.1
    VienMenu.Parent = MenuChinh

    -- ===== THANH TIÊU ĐỀ =====
    local ThanhTieuDe = Instance.new("Frame")
    ThanhTieuDe.Size = UDim2.new(1,0,0,42)
    ThanhTieuDe.BackgroundColor3 = CaiDat.Mau_Nen_Sang
    ThanhTieuDe.BorderSizePixel = 0
    ThanhTieuDe.Parent = MenuChinh
    Instance.new("UICorner", ThanhTieuDe).CornerRadius = UDim.new(0,14)

    local TieuDe = Instance.new("TextLabel")
    TieuDe.Size = UDim2.new(1,-40,1,0)
    TieuDe.Position = UDim2.new(0,12,0,0)
    TieuDe.BackgroundTransparency = 1
    TieuDe.Text = "⚙️ HC Roblox - Menu Đa Năng"
    TieuDe.TextColor3 = CaiDat.Mau_Chu
    TieuDe.Font = Enum.Font.GothamBold
    TieuDe.TextSize = 15
    TieuDe.TextXAlignment = Enum.TextXAlignment.Left
    TieuDe.Parent = ThanhTieuDe

    -- Nút thu gọn
    local NutThuGon = Instance.new("TextButton")
    NutThuGon.Size = UDim2.new(0,32,0,32)
    NutThuGon.Position = UDim2.new(1,-37,0.5,-16)
    NutThuGon.BackgroundColor3 = CaiDat.Mau_Nen
    NutThuGon.Text = CaiDat.Icon_ThuGon
    NutThuGon.TextColor3 = CaiDat.Mau_Chu
    NutThuGon.Font = Enum.Font.GothamBold
    NutThuGon.TextSize = 16
    NutThuGon.AutoButtonColor = false
    NutThuGon.Parent = ThanhTieuDe
    Instance.new("UICorner", NutThuGon).CornerRadius = UDim.new(1,0)

    -- ===== THANH TAB =====
    local ThanhTab = Instance.new("Frame")
    ThanhTab.Size = UDim2.new(1,-10,0,42)
    ThanhTab.Position = UDim2.new(0,5,0,47)
    ThanhTab.BackgroundColor3 = CaiDat.Mau_Nen_Sang
    ThanhTab.BorderSizePixel = 0
    ThanhTab.Parent = MenuChinh
    Instance.new("UICorner", ThanhTab).CornerRadius = UDim.new(0,8)

    -- Danh sách Tab
    local DanhSachTab = {
        {Ten="Di Chuyển", Icon=CaiDat.Icon_DiChuyen},
        {Ten="Hiển Thị", Icon=CaiDat.Icon_HienThi},
        {Ten="Nhân Vật", Icon=CaiDat.Icon_NhanVat},
        {Ten="Khác", Icon=CaiDat.Icon_Them},
    }
    local NutTab = {}
    local KhungNoiDung = {}

    -- Tạo từng Tab
    for i, tab in ipairs(DanhSachTab) do
        local btnTab = Instance.new("TextButton")
        btnTab.Size = UDim2.new(1/#DanhSachTab, -4, 1, -4)
        btnTab.Position = UDim2.new((i-1)/#DanhSachTab, 2, 0, 2)
        btnTab.BackgroundColor3 = i==1 and CaiDat.Mau_Tab_Chon or CaiDat.Mau_Nen
        btnTab.Text = tab.Icon
        btnTab.TextColor3 = CaiDat.Mau_Chu
        btnTab.Font = Enum.Font.GothamBold
        btnTab.TextSize = 17
        btnTab.AutoButtonColor = false
        btnTab.Parent = ThanhTab
        Instance.new("UICorner", btnTab).CornerRadius = UDim.new(0,6)
        NutTab[i] = btnTab

        -- Khung nội dung Tab
        local nd = Instance.new("Frame")
        nd.Size = UDim2.new(1,-10,1,-98)
        nd.Position = UDim2.new(0,5,0,92)
        nd.BackgroundTransparency = 1
        nd.Visible = i==1
        nd.ClipsDescendants = true
        nd.Parent = MenuChinh
        local list = Instance.new("UIListLayout")
        list.Padding = UDim.new(0,9)
        list.SortOrder = Enum.SortOrder.LayoutOrder
        list.Parent = nd
        KhungNoiDung[i] = nd
    end

    -- Chuyển Tab
    local function ChuyenTab(so)
        TrangThai.TabHienTai = so
        for i=1,4 do
            NutTab[i].BackgroundColor3 = i==so and CaiDat.Mau_Tab_Chon or CaiDat.Mau_Nen
            KhungNoiDung[i].Visible = i==so
        end
    end
    for i=1,4 do
        NutTab[i].MouseButton1Click:Connect(function() ChuyenTab(i) end)
        NutTab[i].TouchTap:Connect(function() ChuyenTab(i) end)
    end

    -- ===== HÀM TẠO NÚT CHỨC NĂNG =====
    local function TaoNut(tab, ten, icon, bien)
        local Nut = Instance.new("TextButton")
        Nut.Size = CaiDat.KichThuoc_Nut
        Nut.BackgroundColor3 = CaiDat.Mau_Nen_Sang
        Nut.Text = icon.." "..ten.." : TẮT"
        Nut.TextColor3 = CaiDat.Mau_Do
        Nut.Font = Enum.Font.GothamSemibold
        Nut.TextSize = 14
        Nut.AutoButtonColor = false
        Nut.TextXAlignment = Enum.TextXAlignment.Left
        Nut.TextPadding = UDim.new(0,12)
        Nut.Parent = KhungNoiDung[tab]
        Instance.new("UICorner", Nut).CornerRadius = UDim.new(0,8)
        local VienNut = Instance.new("UIStroke")
        VienNut.Color = CaiDat.Mau_Vien
        VienNut.Thickness = 1
        VienNut.Transparency = 0.5
        VienNut.Parent = Nut

        -- Cập nhật trạng thái nút
        function Nut.CapNhat()
            if TrangThai[bien] then
                Nut.Text = icon.." "..ten.." : BẬT"
                Nut.TextColor3 = CaiDat.Mau_Xanh
                VienNut.Transparency = 0.1
            else
                Nut.Text = icon.." "..ten.." : TẮT"
                Nut.TextColor3 = CaiDat.Mau_Do
                VienNut.Transparency = 0.5
            end
        end
        return Nut
    end

    -- ===== BONG BÓNG =====
    local BongBong = Instance.new("ImageButton")
    BongBong.Size = CaiDat.KichThuoc_BongBong
    BongBong.Position = MenuChinh.Position
    BongBong.BackgroundColor3 = CaiDat.Mau_BongBong
    BongBong.Image = CaiDat.Link_AnhBongBong
    BongBong.Visible = false
    BongBong.Active = true
    BongBong.Draggable = true
    BongBong.AutoButtonColor = false
    BongBong.Parent = ScreenGui
    Instance.new("UICorner", BongBong).CornerRadius = UDim.new(1,0)
    Instance.new("UIStroke", BongBong).Color = CaiDat.Mau_Vien
    Instance.new("UIStroke", BongBong).Thickness = 2.5

    -- Chuyển Menu ↔ Bong bóng
    local function ChuyenMenu()
        TrangThai.MenuDangMo = not TrangThai.MenuDangMo
        if TrangThai.MenuDangMo then
            MenuChinh.Visible = true
            BongBong.Visible = false
        else
            BongBong.Position = MenuChinh.Position
            MenuChinh.Visible = false
            BongBong.Visible = true
        end
    end
    NutThuGon.MouseButton1Click:Connect(ChuyenMenu)
    BongBong.MouseButton1Click:Connect(ChuyenMenu)
    NutThuGon.TouchTap:Connect(ChuyenMenu)
    BongBong.TouchTap:Connect(ChuyenMenu)

    return {
        Khung=KhungNoiDung, TaoNut=TaoNut, ChuyenMenu=ChuyenMenu,
        NutTab=NutTab
    }
end
-- Khởi tạo UI an toàn
local GiaoDien = TaoUI()
if not GiaoDien then return end

-- ======================
-- 🔌 KẾT NỐI NHÂN VẬT AN TOÀN
-- ======================
local function KetNhanVat(nv)
    if not nv then return end
    Character = nv
    Humanoid = Character:WaitForChild("Humanoid", 5)
    RootPart = Character:WaitForChild("HumanoidRootPart", 5)
    -- Reset chức năng khi đổi nhân vật
    if BodyVelocity then BodyVelocity:Destroy() end
    if BodyGyro then BodyGyro:Destroy() end
    TrangThai.Fly = false
    TrangThai.TangHinh = false
    if AnhSang then AnhSang:Destroy() end
    AnhSang = nil
end
-- Kết nối ngay khi có nhân vật
if LocalPlayer.Character then KetNhanVat(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(KetNhanVat)

-- ======================
-- 🚀 KHAI BÁO NÚT CHỨC NĂNG (ĐÃ THÊM MỚI)
-- ======================
-- Tab 1: Di Chuyển
local NutTangToc = GiaoDien.TaoNut(1, "Tăng tốc chạy", CaiDat.Icon_TangToc, "TangToc")
local NutGiamToc = GiaoDien.TaoNut(1, "Chạy chậm lại", CaiDat.Icon_GiamToc, "GiamToc")
local NutNhayCao = GiaoDien.TaoNut(1, "Nhảy cao", CaiDat.Icon_NhayCao, "NhayCao")
local NutFly = GiaoDien.TaoNut(1, "Bay tự do", CaiDat.Icon_Fly, "Fly")
local NutBayNhanh = GiaoDien.TaoNut(1, "Bay cực nhanh", CaiDat.Icon_CucNhanh, "BayNhanh")
local NutBayCao = GiaoDien.TaoNut(1, "Bay lên cao", CaiDat.Icon_BayCao, "BayCao")

-- Tab 2: Hiển Thị
local NutESP = GiaoDien.TaoNut(2, "ESP Người chơi", CaiDat.Icon_ESP, "ESP")
local NutXemQuaTuong = GiaoDien.TaoNut(2, "Xem xuyên tường", CaiDat.Icon_XemQuaTuong, "XemQuaTuong")
local NutLuonSang = GiaoDien.TaoNut(2, "Luôn sáng khu vực", CaiDat.Icon_LuonSang, "LuonSang")
local NutTangHinh = GiaoDien.TaoNut(2, "Tàng hình", CaiDat.Icon_TangHinh, "TangHinh")
local NutChatMau = GiaoDien.TaoNut(2, "Chế độ đầy màu", CaiDat.Icon_ChatMau, "ChatMau")

-- Tab 3: Nhân Vật
local NutKhongRoi = GiaoDien.TaoNut(3, "Không bị rơi", CaiDat.Icon_KhongRoi, "KhongRoi")
local NutBatTu = GiaoDien.TaoNut(3, "Bất tử", CaiDat.Icon_BatTu, "BatTu")
local NutVoCuc = GiaoDien.TaoNut(3, "Đẩy cực mạnh", CaiDat.Icon_DayManh, "VoCuc")
local NutKhongMatNen = GiaoDien.TaoNut(3, "Không mất năng lượng", CaiDat.Icon_KhongMatNen, "KhongMatNen")

-- ======================
-- ⚡ HOẠT ĐỘNG CHỨC NĂNG
-- ======================
-- Cập nhật tất cả nút
local function CapNhatTatCa()
    NutTangToc.CapNhat() NutGiamToc.CapNhat() NutNhayCao.CapNhat() NutFly.CapNhat()
    NutBayNhanh.CapNhat() NutBayCao.CapNhat() NutESP.CapNhat() NutXemQuaTuong.CapNhat()
    NutLuonSang.CapNhat() NutTangHinh.CapNhat() NutChatMau.CapNhat() NutKhongRoi.CapNhat()
    NutBatTu.CapNhat() NutVoCuc.CapNhat() NutKhongMatNen.CapNhat()
end

-- 1. Tăng tốc
NutTangToc.MouseButton1Click:Connect(function()
    TrangThai.TangToc = not TrangThai.TangToc
    if Humanoid then Humanoid.WalkSpeed = TrangThai.TangToc and CaiDat.SpeedChay or 16 end
    CapNhatTatCa()
end)
NutTangToc.TouchTap:Connect(NutTangToc.MouseButton1Click)

-- 2. Giảm tốc (MỚI)
NutGiamToc.MouseButton1Click:Connect(function()
    TrangThai.GiamToc = not TrangThai.GiamToc
    if Humanoid then Humanoid.WalkSpeed = TrangThai.GiamToc and 8 or 16 end
    CapNhatTatCa()
end)
NutGiamToc.TouchTap:Connect(NutGiamToc.MouseButton1Click)

-- 3. Nhảy cao
NutNhayCao.MouseButton1Click:Connect(function()
    TrangThai.NhayCao = not TrangThai.NhayCao
    if Humanoid then Humanoid.JumpPower = TrangThai.NhayCao and CaiDat.JumpCao or 50 end
    CapNhatTatCa()
end)
NutNhayCao.TouchTap:Connect(NutNhayCao.MouseButton1Click)

-- 4. Bay tự do
local function ToggleFly()
    TrangThai.Fly = not TrangThai.Fly
    if not RootPart then return end
    if TrangThai.Fly then
        BodyVelocity = Instance.new("BodyVelocity", RootPart)
        BodyVelocity.MaxForce = Vector3.new(1e9,1e9,1e9)
        BodyGyro = Instance.new("BodyGyro", RootPart)
        BodyGyro.MaxTorque = Vector3.new(1e9,1e9,1e9)
        Humanoid.PlatformStand = true
    else
        if BodyVelocity then BodyVelocity:Destroy() end
        if BodyGyro then BodyGyro:Destroy() end
        Humanoid.PlatformStand = false
    end
    CapNhatTatCa()
end
NutFly.MouseButton1Click:Connect(ToggleFly)
NutFly.TouchTap:Connect(ToggleFly)

-- Di chuyển bay mượt mà
RunService.RenderStepped:Connect(function()
    if not TrangThai.Fly or not RootPart then return end
    local tocDo = TrangThai.BayNhanh and CaiDat.SpeedBayNhanh or CaiDat.SpeedFly
    local huong = Vector3.zero
    local cf = Camera.CFrame
    if UIS:IsKeyDown(Enum.KeyCode.W) then huong += cf.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.S) then huong -= cf.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.A) then huong -= cf.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.D) then huong += cf.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then huong += Vector3.new(0,1,0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then huong -= Vector3.new(0,1,0) end
    huong = huong.Magnitude>0 and huong.Unit*tocDo or Vector3.zero
    BodyVelocity.Velocity = huong
    BodyGyro.CFrame = cf
end)

-- 5. Bay nhanh
NutBayNhanh.MouseButton1Click:Connect(function()
    TrangThai.BayNhanh = not TrangThai.BayNhanh
    CapNhatTatCa()
end)
NutBayNhanh.TouchTap:Connect(NutBayNhanh.MouseButton1Click)

-- 6. Bay cao
NutBayCao.MouseButton1Click:Connect(function()
    TrangThai.BayCao = not TrangThai.BayCao
    if RootPart then RootPart.Velocity = Vector3.new(0, TrangThai.BayCao and CaiDat.KhoangCao or 0, 0) end
    CapNhatTatCa()
end)
NutBayCao.TouchTap:Connect(NutBayCao.MouseButton1Click)

-- 7. ESP
NutESP.MouseButton1Click:Connect(function()
    TrangThai.ESP = not TrangThai.ESP
    if TrangThai.ESP then
        for _,p in pairs(Players:GetPlayers()) do
            if p~=LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local dau = p.Character.Head
                local gui = Instance.new("BillboardGui", dau)
                gui.AlwaysOnTop = true
                gui.Size = UDim2.new(0,150,0,40)
                gui.Adornee = dau
                local txt = Instance.new("TextLabel", gui)
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.Text = CaiDat.Icon_ESP.." "..p.Name
                txt.TextColor3 = Color3.new(1,0.3,0.3)
                txt.Font = Enum.Font.GothamBold
                txt.TextSize = 16
                ESPs[p] = gui
            end
        end
    else
        for _,v in pairs(ESPs) do v:Destroy() end
        ESPs = {}
    end
    CapNhatTatCa()
end)
NutESP.TouchTap:Connect(NutESP.MouseButton1Click)

-- 8. Xem xuyên tường
NutXemQuaTuong.MouseButton1Click:Connect(function()
    TrangThai.XemQuaTuong = not TrangThai.XemQuaTuong
    Camera.FieldOfView = TrangThai.XemQuaTuong and 85 or 70
    Camera.LensFlare = TrangThai.XemQuaTuong
    CapNhatTatCa()
end)
NutXemQuaTuong.TouchTap:Connect(NutXemQuaTuong.MouseButton1Click)

-- 9. Luôn sáng
NutLuonSang.MouseButton1Click:Connect(function()
    TrangThai.LuonSang = not TrangThai.LuonSang
    if TrangThai.LuonSang and RootPart then
        AnhSang = Instance.new("PointLight", RootPart)
        AnhSang.Brightness = 3.5
        AnhSang.Range = 35
        AnhSang.Color = Color3.new(1,1,0.7)
    else
        if AnhSang then AnhSang:Destroy() end
    end
    CapNhatTatCa()
end)
NutLuonSang.TouchTap:Connect(NutLuonSang.MouseButton1Click)

-- 10. Tàng hình
NutTangHinh.MouseButton1Click:Connect(function()
    TrangThai.TangHinh = not TrangThai.TangHinh
    local t = TrangThai.TangHinh and 0.05 or 1
    local c = TrangThai.TangHinh and Enum.CanCollide.No or Enum.CanCollide.Yes
    if Character then
        for _,p in pairs(Character:GetChildren()) do
            if p:IsA("BasePart") or p:IsA("Decal") then
                p.Transparency = t
                if p:IsA("BasePart") then p.CanCollide = c end
            end
        end
    end
    CapNhatTatCa()
end)
NutTangHinh.TouchTap:Connect(NutTangHinh.MouseButton1Click)

-- 11. Chế độ màu (MỚI)
NutChatMau.MouseButton1Click:Connect(function()
    TrangThai.ChatMau = not TrangThai.ChatMau
    Camera.ColorCorrection.TintColor = TrangThai.ChatMau and Color3.new(1.2,1.1,1.5) or Color3.new(1,1,1)
    CapNhatTatCa()
end)
NutChatMau.TouchTap:Connect(NutChatMau.MouseButton1Click)

-- 12. Không rơi
NutKhongRoi.MouseButton1Click:Connect(function()
    TrangThai.KhongRoi = not TrangThai.KhongRoi
    if Humanoid then Humanoid.FloorMaterial = TrangThai.KhongRoi and Enum.Material.Grass or Enum.Material.Air end
    CapNhatTatCa()
end)
NutKhongRoi.TouchTap:Connect(NutKhongRoi.MouseButton1Click)

-- 13. Bất tử
NutBatTu.MouseButton1Click:Connect(function()
    TrangThai.BatTu = not TrangThai.BatTu
    if Humanoid then
        Humanoid.MaxHealth = TrangThai.BatTu and math.huge or 100
        Humanoid.Health = Humanoid.MaxHealth
    end
    CapNhatTatCa()
end)
NutBatTu.TouchTap:Connect(NutBatTu.MouseButton1Click)

-- Phím tắt F4
UIS.InputBegan:Connect(function(i,xl)
    if xl then return end
    if i.KeyCode == CaiDat.Key_Menu and GiaoDien then
        GiaoDien.ChuyenMenu()
    end
end)
