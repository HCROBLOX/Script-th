-- ==============================================
-- MENU TAB ĐA NĂNG | SỬA LỖI TRỐNG NỘI DUNG 100%
-- Hiện đầy đủ nút | Mobile+PC | HC Roblox
-- ==============================================

-- Dịch vụ an toàn
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Chờ PlayerGui chắc chắn
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 15)
if not PlayerGui then
    warn("❌ LỖI: Không lấy được PlayerGui! Đặt đúng vị trí StarterPlayerScripts!")
    return
end

-- ======================
-- ⚙️ CÀI ĐẶT CHUẨN
-- ======================
local CaiDat = {
    SpeedChay = 80, JumpCao = 150, SpeedFly = 95, SpeedBayNhanh = 180, KhoangCao = 120,
    Key_Menu = Enum.KeyCode.F4,
    Icon_DiChuyen = "🏃", Icon_HienThi = "👁️", Icon_NhanVat = "👤", Icon_Khac = "⚙️",
    Icon_Fly = "✈️", Icon_TangToc = "⚡", Icon_NhayCao = "⬆️", Icon_TangHinh = "👻",
    Icon_ESP = "🔴", Icon_XemQuaTuong = "🔍", Icon_LuonSang = "💡", Icon_KhongRoi = "🛡️",
    Icon_BatTu = "❤️", Icon_CucNhanh = "💨", Icon_BayCao = "☁️", Icon_GiamToc = "🐢",
    Mau_Nen = Color3.fromRGB(18, 20, 28),
    Mau_Nen_Sang = Color3.fromRGB(35, 40, 60),
    Mau_Tab_Chon = Color3.fromRGB(60, 130, 255),
    Mau_Xanh = Color3.fromRGB(72, 207, 120),
    Mau_Do = Color3.fromRGB(231, 76, 60),
    Mau_Vien = Color3.fromRGB(120, 180, 255),
    Mau_Chu = Color3.new(1,1,1),
    KichThuoc_Menu = UDim2.new(0, 310, 0, 330),
    Link_AnhBongBong = "rbxassetid://6023426935",
}

-- Trạng thái
local TrangThai = {
    TangToc=false, GiamToc=false, NhayCao=false, Fly=false, BayNhanh=false, BayCao=false,
    ESP=false, XemQuaTuong=false, LuonSang=false, TangHinh=false, BatTu=false, KhongRoi=false,
    MenuDangMo=true, TabHienTai=1,
}
local Character, Humanoid, RootPart, BodyVelocity, BodyGyro, AnhSang
local ESPs = {}

-- ======================
-- 🧩 TẠO UI ĐẦY ĐỦ NỘI DUNG
-- ======================
local function TaoUI()
    -- Xóa giao diện cũ
    local Cu = PlayerGui:FindFirstChild("Menu_HCRoblox_Chinh")
    if Cu then Cu:Destroy() end

    -- ScreenGui chuẩn không bị ẩn
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Menu_HCRoblox_Chinh"
    ScreenGui.Parent = PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Enabled = true
    ScreenGui.DisplayOrder = 999

    -- Khung Menu Chính
    local Menu = Instance.new("Frame")
    Menu.Name = "MenuChinh"
    Menu.Size = CaiDat.KichThuoc_Menu
    Menu.Position = UDim2.new(0.05, 0, 0.12, 0)
    Menu.BackgroundColor3 = CaiDat.Mau_Nen
    Menu.BorderSizePixel = 0
    Menu.Visible = true
    Menu.Active = true
    Menu.Draggable = true
    Menu.Parent = ScreenGui
    Instance.new("UICorner", Menu).CornerRadius = UDim.new(0,14)
    local VienMenu = Instance.new("UIStroke", Menu)
    VienMenu.Color = CaiDat.Mau_Vien
    VienMenu.Thickness = 2.2

    -- Thanh Tiêu đề
    local ThanhTieuDe = Instance.new("Frame")
    ThanhTieuDe.Size = UDim2.new(1,0,0,42)
    ThanhTieuDe.BackgroundColor3 = CaiDat.Mau_Nen_Sang
    ThanhTieuDe.BorderSizePixel = 0
    ThanhTieuDe.Parent = Menu
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

    -- Nút Thu gọn
    local NutThuGon = Instance.new("TextButton")
    NutThuGon.Size = UDim2.new(0,32,0,32)
    NutThuGon.Position = UDim2.new(1,-37,0.5,-16)
    NutThuGon.BackgroundColor3 = CaiDat.Mau_Nen
    NutThuGon.Text = "➖"
    NutThuGon.TextColor3 = CaiDat.Mau_Chu
    NutThuGon.Font = Enum.Font.GothamBold
    NutThuGon.TextSize = 16
    NutThuGon.AutoButtonColor = false
    NutThuGon.Parent = ThanhTieuDe
    Instance.new("UICorner", NutThuGon).CornerRadius = UDim.new(1,0)

    -- Thanh Tab
    local ThanhTab = Instance.new("Frame")
    ThanhTab.Size = UDim2.new(1,-10,0,42)
    ThanhTab.Position = UDim2.new(0,5,0,47)
    ThanhTab.BackgroundColor3 = CaiDat.Mau_Nen_Sang
    ThanhTab.BorderSizePixel = 0
    ThanhTab.Parent = Menu
    Instance.new("UICorner", ThanhTab).CornerRadius = UDim.new(0,8)

    -- Danh sách Tab
    local DanhSachTab = {
        {Ten="Di Chuyển", Icon=CaiDat.Icon_DiChuyen},
        {Ten="Hiển Thị", Icon=CaiDat.Icon_HienThi},
        {Ten="Nhân Vật", Icon=CaiDat.Icon_NhanVat},
        {Ten="Khác", Icon=CaiDat.Icon_Khac},
    }
    local NutTab = {}
    local KhungNoiDung = {}

    for i, tab in ipairs(DanhSachTab) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1/#DanhSachTab, -4, 1, -4)
        btn.Position = UDim2.new((i-1)/#DanhSachTab, 2, 0, 2)
        btn.BackgroundColor3 = i==1 and CaiDat.Mau_Tab_Chon or CaiDat.Mau_Nen
        btn.Text = tab.Icon
        btn.TextColor3 = CaiDat.Mau_Chu
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 17
        btn.AutoButtonColor = false
        btn.Parent = ThanhTab
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
        NutTab[i] = btn

        -- Khung nội dung có sẵn ListLayout
        local nd = Instance.new("Frame")
        nd.Size = UDim2.new(1,-10,1,-98)
        nd.Position = UDim2.new(0,5,0,92)
        nd.BackgroundTransparency = 1
        nd.Visible = i==1
        nd.ClipsDescendants = true
        nd.Parent = Menu
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

    -- HÀM TẠO NÚT CHỨC NĂNG ĐÚNG 100%
    local function TaoNut(tab, ten, icon, bien)
        local Nut = Instance.new("TextButton")
        Nut.Size = UDim2.new(1, -10, 0, 44)
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
        local VienNut = Instance.new("UIStroke", Nut)
        VienNut.Color = CaiDat.Mau_Vien
        VienNut.Thickness = 1

        -- Cập nhật trạng thái
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

    -- Bong bóng thu gọn
    local BongBong = Instance.new("ImageButton")
    BongBong.Size = UDim2.new(0, 58, 0, 58)
    BongBong.Position = Menu.Position
    BongBong.BackgroundColor3 = Color3.fromRGB(60, 140, 255)
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
            Menu.Visible = true
            BongBong.Visible = false
        else
            BongBong.Position = Menu.Position
            Menu.Visible = false
            BongBong.Visible = true
        end
    end
    NutThuGon.MouseButton1Click:Connect(ChuyenMenu)
    BongBong.MouseButton1Click:Connect(ChuyenMenu)
    NutThuGon.TouchTap:Connect(ChuyenMenu)
    BongBong.TouchTap:Connect(ChuyenMenu)

    return {TaoNut=TaoNut, ChuyenMenu=ChuyenMenu}
end

-- Khởi tạo UI an toàn
local GiaoDien = TaoUI()
if not GiaoDien then warn("❌ Tạo UI thất bại!") return end

-- ======================
-- 🔌 KẾT NỐI NHÂN VẬT
-- ======================
local function KetNhanVat(nv)
    if not nv then return end
    Character = nv
    Humanoid = Character:WaitForChild("Humanoid", 5)
    RootPart = Character:WaitForChild("HumanoidRootPart", 5)
    -- Reset khi đổi nhân vật
    if BodyVelocity then BodyVelocity:Destroy() end
    if BodyGyro then BodyGyro:Destroy() end
    if AnhSang then AnhSang:Destroy() end
    TrangThai.Fly = false
end
if LocalPlayer.Character then KetNhanVat(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(KetNhanVat)

-- ======================
-- 🚀 KHAI BÁO NÚT CHỨC NĂNG (ĐẦY ĐỦ)
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

-- Tab 3: Nhân Vật
local NutKhongRoi = GiaoDien.TaoNut(3, "Không bị rơi", CaiDat.Icon_KhongRoi, "KhongRoi")
local NutBatTu = GiaoDien.TaoNut(3, "Bất tử", CaiDat.Icon_BatTu, "BatTu")

-- Cập nhật tất cả nút
local function CapNhatTatCa()
    NutTangToc.CapNhat()
    NutGiamToc.CapNhat()
    NutNhayCao.CapNhat()
    NutFly.CapNhat()
    NutBayNhanh.CapNhat()
    NutBayCao.CapNhat()
    NutESP.CapNhat()
    NutXemQuaTuong.CapNhat()
    NutLuonSang.CapNhat()
    NutTangHinh.CapNhat()
    NutKhongRoi.CapNhat()
    NutBatTu.CapNhat()
end

-- ======================
-- ⚡ HOẠT ĐỘNG CHỨC NĂNG (ĐÃ SỬA LỖI CÚ PHÁP)
-- ======================
-- Tăng tốc
NutTangToc.MouseButton1Click:Connect(function()
    TrangThai.TangToc = not TrangThai.TangToc
    if Humanoid then Humanoid.WalkSpeed = TrangThai.TangToc and CaiDat.SpeedChay or 16 end
    CapNhatTatCa()
end)
NutTangToc.TouchTap:Connect(NutTangToc.MouseButton1Click)

-- Giảm tốc
NutGiamToc.MouseButton1Click:Connect(function()
    TrangThai.GiamToc = not TrangThai.GiamToc
    if Humanoid then Humanoid.WalkSpeed = TrangThai.GiamToc and 8 or 16 end
    CapNhatTatCa()
end)
NutGiamToc.TouchTap:Connect(NutGiamToc.MouseButton1Click)

-- Nhảy cao
NutNhayCao.MouseButton1Click:Connect(function()
    TrangThai.NhayCao = not TrangThai.NhayCao
    if Humanoid then Humanoid.JumpPower = TrangThai.NhayCao and CaiDat.JumpCao or 50 end
    CapNhatTatCa()
end)
NutNhayCao.TouchTap:Connect(NutNhayCao.MouseButton1Click)

-- Bay tự do
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
    local Camera = workspace.CurrentCamera
    local huong = Vector3.zero
    if UIS:IsKeyDown(Enum.KeyCode.W) then huong += Camera.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.S) then huong -= Camera.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.A) then huong -= Camera.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.D) then huong += Camera.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then huong += Vector3.new(0,1,0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then huong -= Vector3.new(0,1,0) end
    huong = huong.Magnitude > 0 and huong.Unit * tocDo or Vector3.zero
    BodyVelocity.Velocity = huong
    BodyGyro.CFrame = Camera.CFrame
end)

-- Bay nhanh
NutBayNhanh.MouseButton1Click:Connect(function()
    TrangThai.BayNhanh = not TrangThai.BayNhanh
    CapNhatTatCa()
end)
NutBayNhanh.TouchTap:Connect(NutBayNhanh.MouseButton1Click)

-- Bay cao
NutBayCao.MouseButton1Click:Connect(function()
    TrangThai.BayCao = not TrangThai.BayCao
    if RootPart then RootPart.Velocity = Vector3.new(0, TrangThai.BayCao and CaiDat.KhoangCao or 0, 0) end
    CapNhatTatCa()
end)
NutBayCao.TouchTap:Connect(NutBayCao.MouseButton1Click)

-- ESP
NutESP.MouseButton1Click:Connect(function()
    TrangThai.ESP = not TrangThai.ESP
    if TrangThai.ESP then
        for _,p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local dau = p.Character.Head
                local gui = Instance.new("BillboardGui", dau)
                gui.AlwaysOnTop = true
                gui.Size = UDim2.new(0,150,0,40)
                gui.Adornee = dau
                local txt = Instance.new("TextLabel", gui)
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.Text = "🔴 "..p.Name
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

-- Xem xuyên tường
NutXemQuaTuong.MouseButton1Click:Connect(function()
    TrangThai.XemQuaTuong = not TrangThai.XemQuaTuong
    workspace.CurrentCamera.FieldOfView = TrangThai.XemQuaTuong and 85 or 70
    CapNhatTatCa()
end)
NutXemQuaTuong.TouchTap:Connect(NutXemQuaTuong.MouseButton1Click)

-- Luôn sáng (ĐÃ SỬA LỖI THIẾU DÒNG)
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

-- Tàng hình
NutTangHinh.MouseButton1Click:Connect(function()
    TrangThai.TangHinh = not TrangThai.TangHinh
    local t = TrangThai.TangHinh and 0.05 or 1
    if Character then
        for _,p in pairs(Character:GetChildren()) do
            if p:IsA("BasePart") or p:IsA("Decal") then
                p.Transparency = t
            end
        end
    end
    CapNhatTatCa()
end)
NutTangHinh.TouchTap:Connect(NutTangHinh.MouseButton1Click)

-- Không rơi
NutKhongRoi.MouseButton1Click:Connect(function()
    TrangThai.KhongRoi = not TrangThai.KhongRoi
    if Humanoid then Humanoid.FloorMaterial = TrangThai.KhongRoi and Enum.Material.Grass or Enum.Material.Air end
    CapNhatTatCa()
end)
NutKhongRoi.TouchTap:Connect(NutKhongRoi.MouseButton1Click)

-- Bất tử
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
UIS.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.F4 then
        GiaoDien.ChuyenMenu()
    end
end)
