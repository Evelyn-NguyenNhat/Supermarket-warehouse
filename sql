CREATE DATABASE QUANLISIEUTHI
GO

USE QUANLISIEUTHI
GO
--bảng khách hàng
CREATE TABLE KHACHHANG(
	MaKH char(5) primary key, 
	TenKH nvarchar(40) not null, 
	NgSinh smalldatetime not null, 
	GioiTinh bit not null,
	SDT char(10), 
	DiaChi nvarchar(100), 
	CCCD varchar(12) not null
) 
GO
SELECT* FROM KHACHHANG;
--bảng nhân viên
CREATE TABLE NHANVIEN(
	MaNV char(5) primary key, 
	TenNV nvarchar(40) not null, 
	NgSinh smalldatetime not null,
	GioiTinh bit not null, 
	SDT char(10),
	DiaChi nvarchar(100),
	NgVL smalldatetime not null, --ngayvaolam
	Luong money
)
GO
SELECT* FROM NHANVIEN;
--bảng ca làm việc
CREATE TABLE CALV(
	MaCa char(3) primary key, 
	GioBD smalldatetime not null,  
	SoGio int not null, 
	NgayLe bit not null
) 
GO
SELECT* FROM CALV;
--bảng chi tiết ca làm
CREATE TABLE CTCL(
	MaCa char(3),
	MaNV char(5)

	primary key(MaCa, MaNV)
	constraint FK_CTCL_CALV foreign key (MaCa) references CALV(MaCa),
	constraint FK_CTCL_NV foreign key (MaNV) references NhanVien(MaNV)
) 
GO
SELECT* FROM CTCL;
--bảng loại sản phẩm
CREATE TABLE LOAISP(
	MaLSP char(3) primary key, 
	TenLSP nvarchar(40) not null
)
GO
SELECT* FROM LOAISP;
--bảng sản phẩm
CREATE TABLE SANPHAM(
	MaSP char(8) primary key,  
	TenSP nvarchar(100) not null, 
	GiaBan money not null, 
	TLXN float not null, 
	SL float not null, 
	MaLSP char(3)

	constraint FK_SP_LSP foreign key (MaLSP) references LOAISP(MaLSP)
)
GO
SELECT* FROM SANPHAM;
--bảng nhà cung cấp
CREATE TABLE NHACC(
	MaNCC char(6) primary key,  --mã nhà cung cấp
	TenNCC nvarchar(40) not null, --tên nhà cung cấp
	SDT varchar(11), 
	DiaChi nvarchar(100), 
	NgDD nvarchar(40), --
	MSThue varchar(10) not null
)  
GO
SELECT* FROM NHACC;
--bảng nhà cung cấp sản phẩm
CREATE TABLE NCC_SP(
	MaNCC char(6), 
	MaSP char(8)

	primary key(MaNCC, MaSP)
	constraint FK_NCCSP_SP foreign key (MaSP) references SANPHAM(MaSP),
	constraint FK_NCCSP_NCC foreign key (MaNCC) references NHACC(MaNCC)
)  
GO
SELECT* FROM NCC_SP;
--bảng hóa đơn bán hàng
CREATE TABLE HDBH(
	MaHDBH char(7) primary key, 
	MaNV char(5), 
	MaKH char(5), 
	NgHDBH smalldatetime not null, 
	TriGia money not null

	constraint FK_HDBH_NV foreign key (MaNV) references NHANVIEN(MaNV)
) 
GO
SELECT*FROM HDBH;
---bảng chi tiết hóa đơn bán hàng
CREATE TABLE CTHDBH(
	MaHDBH char(7), 
	MaSP char(8), 
	SL float not null

	primary key(MaHDBH, MaSP)
	constraint FK_CTHDBH_HDBH foreign key (MaHDBH) references HDBH(MaHDBH),
	constraint FK_CTHDBH_SP foreign key (MaSP) references SANPHAM(MaSP)
) 
GO
SELECT* FROM CTHDBH;
---Bảng hóa đơn nhập hàng
CREATE TABLE HDNH(
	MaHDNH char(7) primary key, 
	MaNV char(5), 
	MaNCC char(6), 
	NgHDNH smalldatetime not null, 
	TriGia money not null

	constraint FK_HDNH_NV foreign key (MaNV) references NHANVIEN(MaNV),
	constraint FK_HDNH_NCC foreign key (MaNCC) references NHACC(MaNCC)
) 
GO
SELECT* FROM HDNH;
--Bảng chi tiết hóa đơn nhập hàng
CREATE TABLE CTHDNH(
	MaHDNH char(7),
	MaSP char(8),
	SL float not null,
	HSD smalldatetime, 
	GiaNhap money not null

	primary key(MaHDNH, MaSP)
	constraint FK_CTHDNH_HDNH foreign key (MaHDNH) references HDNH(MaHDNH),
	constraint FK_CTHDNH_SP foreign key (MaSP) references SANPHAM(MaSP)
) 
GO
SELECT* FROM CTHDNH;
---Bảng khuyến mãi
CREATE TABLE KHUYENMAI(
	MaKM char(4) primary key, 
	TenKM nvarchar(100) not null, 
	NgayBD smalldatetime not null, 
	NgayKT smalldatetime not null
) 
GO
SELECT* FROM KHUYENMAI;
--Bảng chi tiết khuyến mãi
CREATE TABLE CTKM(
	MaKM char(4), 
	MaSP char(8), 
	PTKM float not null

	primary key(MaKM, MaSP)
	constraint FK_CTKM_KM foreign key (MaKM) references KHUYENMAI(MaKM),
	constraint FK_CTKM_SP foreign key (MaSP) references SANPHAM(MaSP)
) 
GO
SELECT* FROM CTKM;
---INSERT DU LIEU
use QUANLISIEUTHI
go

-- Insert data
-- Bảng KHACHHANG
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH001', N'Đỗ Đức Thiên Ân', CAST('1995-01-20 00:00:00' AS smalldatetime), '0', '0939871003', N'3 Hòa Bình, P.3, Q.11, Tp.HCM', '79095226123');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH002', N'Lê Diệu Ánh', CAST('2000-09-11 00:00:00' AS smalldatetime), '1', '0867156772', N'246 Nguyễn Hồng Đào, P.13, Q.Tân Bình, Tp.HCM', '1300465236');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH003', N'Đỗ Quốc Bảo', CAST('1999-04-30 00:00:00' AS smalldatetime), '0', '0895735385', N'159/14 Phạm Văn Chiêu, P.14, Q.Gò Vấp, Tp.HCM', '79099765124');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH004', N'Nguyễn Trọng Bảo Chương', CAST('1997-08-06 00:00:00' AS smalldatetime), '0', '0929656535', N'25 Đường Số 3, P.Bình An, Tp.Thủ Đức, Tp.HCM', '48097235098');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH005', N'Trần Ánh Diễm', CAST('1998-07-14 00:00:00' AS smalldatetime), '1', '0882288103', N'8 Đường 339, P.Phước Long B, Tp.Thủ Đức, Tp.HCM', '79198654478');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH006', N'Lê Hoàng Ý Duyên', CAST('2000-02-27 00:00:00' AS smalldatetime), '1', '0940985956', N'407 Lê Văn Thọ, P.9, Q.Gò Vấp, Tp.HCM', '51300126439');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH007', N'Đỗ Ngọc Khánh Giang', CAST('2001-11-11 00:00:00' AS smalldatetime), '1', '0946775425', N'906 Trường Chinh, P.Tây Thạnh, Q.Tân Bình, Tp.HCM', '79301980453');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH008', N' Nguyễn Dương Quang Hiệp', CAST('2004-12-09 00:00:00' AS smalldatetime), '0', '0914185875', N'147 Nguyễn Cửu Đàm, P.Tân Sơn Nhì, Q.Tân Phú, Tp.HCM', '56204214864');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH009', N'Trần Nguyễn Nhật Hoàng', CAST('1998-09-13 00:00:00' AS smalldatetime), '0', '0928572820', N'333 Nguyễn Văn Luông, P.12, Q.6, Tp.HCM', '79098790876');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH010', N'Phạm Đăng Khoa', CAST('1992-12-12 00:00:00' AS smalldatetime), '0', '0871521852', N'105 Đường Số 53, P.Tân Tạo A, Q.Bình Tân, Tp.HCM', '79092567897');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH011', N'Nguyễn Dương Ánh Linh', CAST('2002-08-25 00:00:00' AS smalldatetime), '1', '0928898590', N'100 Bông Sao, P.5, Q.8, Tp.HCM', '40302554321');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH012', N'Trần Đỗ Bảo Loan', CAST('2001-04-14 00:00:00' AS smalldatetime), '1', '0949936046', N'373 Huỳnh Tấn Phát, TT.Nhà Bè, Huyện Nhà Bè, Tp.HCM', '79301760246');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH013', N'Phạm Hoàng Nhật Minh', CAST('1995-02-05 00:00:00' AS smalldatetime), '0', '0854586607', N'132 Tân Mỹ, P.Tân Thuận Tây, Q.7, Tp.HCM', '79095764346');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH014', N'Trương Lê Nhã Nguyên', CAST('2002-06-15 00:00:00' AS smalldatetime), '1', '0954928211', N'33 Trần Bạch Đằng, P.An Khánh, Tp.Thủ Đức, Tp.HCM', '83302234572');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH015', N'Lê Thái Sơn', CAST('1999-01-21 00:00:00' AS smalldatetime), '0', '0818599472', N'92/69 Xô Viết Nghệ Tĩnh, P.21, Q.Bình Thạnh, Tp.HCM', '79099033640');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH016', N'Nguyễn Thanh Thảo', CAST('1997-12-24 00:00:00' AS smalldatetime), '1', '0958408953', N'108 Trần Đình Xu, P.Nguyễn Cư Trinh, Q.1, Tp.HCM', '79197066795');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH017', N'Hoàng Dương Thanh Thúy', CAST('1997-10-10 00:00:00' AS smalldatetime), '1', '0879294114', N'19 Cao Thắng, P.2, Q.3, Tp.HCM', '37197012258');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH018', N'Phạm Thanh Tuyền', CAST('2001-10-20 00:00:00' AS smalldatetime), '1', '0897567947', N'225 Sư Vạn Hạnh, P.9, Q.10, Tp.HCM', '79301798411');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH019', N'Lê Trần Hoàng Việt', CAST('1999-05-05 00:00:00' AS smalldatetime), '0', '0872210608', N'307 Hồng Bàng, P.11, Q.5, Tp.HCM', '79099465213');
INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD) VALUES ('KH020', N'Trần Nhật Vượng', CAST('2002-06-07 00:00:00' AS smalldatetime), '0', '0837480296', N'252 Hưng Nhơn, Xã Tân Kiên, Huyện Bình Chánh, Tp.HCM', '17202064200');
go

-- Bảng NHANVIEN
INSERT INTO NHANVIEN (MaNV, TenNV, NgSinh, GioiTinh, SDT, DiaChi, NgVL, Luong) VALUES ('NV001', N'Nguyễn Thế Anh', CAST('2002-04-07 00:00:00' AS smalldatetime), '0', '0981594441', N'268 Tô Hiến Thành, P.15, Q.10, Tp.HCM', CAST('2020-11-20 00:00:00' AS smalldatetime), '25000');
INSERT INTO NHANVIEN (MaNV, TenNV, NgSinh, GioiTinh, SDT, DiaChi, NgVL, Luong) VALUES ('NV002', N'Trần Bảo Gia Khiêm', CAST('2004-01-04 00:00:00' AS smalldatetime), '0', '0990810217', N'36 An Dương Vương, P.9, Q.5, Tp.HCM', CAST('2023-12-03 00:00:00' AS smalldatetime), '20000');
INSERT INTO NHANVIEN (MaNV, TenNV, NgSinh, GioiTinh, SDT, DiaChi, NgVL, Luong) VALUES ('NV003', N'Lê Nhật Hạ', CAST('2001-09-10 00:00:00' AS smalldatetime), '1', '0965989947', N'336 Hai Bà Trưng, P.Tân Định, Q.1, Tp.HCM', CAST('2022-04-06 00:00:00' AS smalldatetime), '25000');
INSERT INTO NHANVIEN (MaNV, TenNV, NgSinh, GioiTinh, SDT, DiaChi, NgVL, Luong) VALUES ('NV004', N'Phạm Thanh Minh Phụng', CAST('2000-02-28 00:00:00' AS smalldatetime), '1', '0935021747', N'9 Hoàng Hoa Thám, P.6, Q.Bình Thạnh, Tp.HCM', CAST('2019-10-07 00:00:00' AS smalldatetime), '25000');
INSERT INTO NHANVIEN (MaNV, TenNV, NgSinh, GioiTinh, SDT, DiaChi, NgVL, Luong) VALUES ('NV005', N'Trương Khôi Nguyên', CAST('2000-02-01 00:00:00' AS smalldatetime), '0', '0960027530', N'20 Cộng Hoà, P.4, Q.Tân Bình, Tp.HCM', CAST('2018-09-15 00:00:00' AS smalldatetime), '30000');
INSERT INTO NHANVIEN (MaNV, TenNV, NgSinh, GioiTinh, SDT, DiaChi, NgVL, Luong) VALUES ('NV006', N'Đỗ Bảo Loan', CAST('2003-06-15 00:00:00' AS smalldatetime), '1', '0939438712', N'76 Hoàng Diệu, P.12, Q.4, Tp.HCM', CAST('2021-02-28 00:00:00' AS smalldatetime), '25000');
go

-- Bảng CALV
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M01', CAST('2024-04-01 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A01', CAST('2024-04-01 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E01', CAST('2024-04-01 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M02', CAST('2024-04-02 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A02', CAST('2024-04-02 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E02', CAST('2024-04-02 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M03', CAST('2024-04-03 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A03', CAST('2024-04-03 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E03', CAST('2024-04-03 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M04', CAST('2024-04-04 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A04', CAST('2024-04-04 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E04', CAST('2024-04-04 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M05', CAST('2024-04-05 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A05', CAST('2024-04-05 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E05', CAST('2024-04-05 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M06', CAST('2024-04-06 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A06', CAST('2024-04-06 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E06', CAST('2024-04-06 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M07', CAST('2024-04-07 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A07', CAST('2024-04-07 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E07', CAST('2024-04-07 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M08', CAST('2024-04-08 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A08', CAST('2024-04-08 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E08', CAST('2024-04-08 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M09', CAST('2024-04-09 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A09', CAST('2024-04-09 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E09', CAST('2024-04-09 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M10', CAST('2024-04-10 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A10', CAST('2024-04-10 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E10', CAST('2024-04-10 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M11', CAST('2024-04-11 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A11', CAST('2024-04-11 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E11', CAST('2024-04-11 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M12', CAST('2024-04-12 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A12', CAST('2024-04-12 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E12', CAST('2024-04-12 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M13', CAST('2024-04-13 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A13', CAST('2024-04-13 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E13', CAST('2024-04-13 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M14', CAST('2024-04-14 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A14', CAST('2024-04-14 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E14', CAST('2024-04-14 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M15', CAST('2024-04-15 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A15', CAST('2024-04-15 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E15', CAST('2024-04-15 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M16', CAST('2024-04-16 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A16', CAST('2024-04-16 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E16', CAST('2024-04-16 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M17', CAST('2024-04-17 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A17', CAST('2024-04-17 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E17', CAST('2024-04-17 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M18', CAST('2024-04-18 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A18', CAST('2024-04-18 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E18', CAST('2024-04-18 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M19', CAST('2024-04-19 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A19', CAST('2024-04-19 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E19', CAST('2024-04-19 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M20', CAST('2024-04-20 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A20', CAST('2024-04-20 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E20', CAST('1900-04-20 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M21', CAST('2024-04-21 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A21', CAST('2024-04-21 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E21', CAST('2024-04-21 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M22', CAST('2024-04-22 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A22', CAST('2024-04-22 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E22', CAST('2024-04-22 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M23', CAST('2024-04-23 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A23', CAST('2024-04-23 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E23', CAST('2024-04-23 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M24', CAST('2024-04-24 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A24', CAST('2024-04-24 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E24', CAST('2024-04-24 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M25', CAST('2024-04-25 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A25', CAST('2024-04-25 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E25', CAST('2024-04-25 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M26', CAST('2024-04-26 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A26', CAST('2024-04-26 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E26', CAST('2024-04-26 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M27', CAST('2024-04-27 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A27', CAST('2024-04-27 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E27', CAST('2024-04-27 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M28', CAST('2024-04-28 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A28', CAST('2024-04-28 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E28', CAST('2024-04-28 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M29', CAST('2024-04-29 07:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A29', CAST('2024-04-29 12:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E29', CAST('2024-04-29 17:00:00' AS smalldatetime), '5', '0');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('M30', CAST('2024-04-30 07:00:00' AS smalldatetime), '5', '1');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('A30', CAST('2024-04-30 12:00:00' AS smalldatetime), '5', '1');
INSERT INTO CALV (MaCa, GioBD, SoGio, NgayLe) VALUES ('E30', CAST('2024-04-30 17:00:00' AS smalldatetime), '5', '1');
go

-- Bảng CTCL
INSERT INTO CTCL (MaCa, MaNV) VALUES ('M01', 'NV001');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('A01', 'NV003');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('E01', 'NV002');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('M05', 'NV001');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('A05', 'NV006');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('E05', 'NV003');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('M08', 'NV002');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('A08', 'NV005');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('E08', 'NV004');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('M12', 'NV006');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('A12', 'NV001');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('E12', 'NV003');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('M15', 'NV004');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('A15', 'NV006');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('E15', 'NV003');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('M17', 'NV006');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('A17', 'NV005');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('E17', 'NV001');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('M20', 'NV006');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('A20', 'NV005');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('E20', 'NV004');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('M22', 'NV005');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('A22', 'NV006');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('E22', 'NV004');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('M23', 'NV005');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('A23', 'NV002');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('E23', 'NV006');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('M25', 'NV006');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('A25', 'NV002');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('E25', 'NV004');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('M26', 'NV003');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('A26', 'NV005');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('E26', 'NV002');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('M29', 'NV006');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('A29', 'NV001');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('E29', 'NV003');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('M30', 'NV004');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('A30', 'NV002');
INSERT INTO CTCL (MaCa, MaNV) VALUES ('E30', 'NV003');
go

-- Bảng LOAISP
INSERT INTO LOAISP (MaLSP, TenLSP) VALUES ('TP1', N'Đồ ăn chế biến sẵn');
INSERT INTO LOAISP (MaLSP, TenLSP) VALUES ('TP2', N'Thực phẩm khô');
INSERT INTO LOAISP (MaLSP, TenLSP) VALUES ('TP3', N'Thực phẩm đông lạnh');
INSERT INTO LOAISP (MaLSP, TenLSP) VALUES ('TP4', N'Thực phẩm tươi');
INSERT INTO LOAISP (MaLSP, TenLSP) VALUES ('GV1', N'Gia vị');
INSERT INTO LOAISP (MaLSP, TenLSP) VALUES ('DU1', N'Đồ uống');
INSERT INTO LOAISP (MaLSP, TenLSP) VALUES ('VP1', N'Văn phòng phẩm');
INSERT INTO LOAISP (MaLSP, TenLSP) VALUES ('HP1', N'Hoá phẩm, vệ sinh');
go

-- Bảng SANPHAM

INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP1BM001', N'Bánh mì thịt', '20400', 1.7, 0, 'TP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP1BM002', N'Bánh mì heo quay', '25500', 1.7, 0, 'TP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP1SW001', N'Sandwich jambon', '22400', 1.697, 0, 'TP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP1SW002', N'Sandwich cá ngừ', '28600', 1.702, 0, 'TP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP1HD001', N'Hot dog', '18400', 1.704, 0, 'TP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP1BB001', N'Bánh bao', '12200', 1.694, 0, 'TP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP1MI001', N'Mì trộn Indo', '25500', 1.7, 0, 'TP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP1MI002', N'Mì cay Hàn Quốc', '30600', 1.7, 0, 'TP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP1XX001', N'Xúc xích nướng', '14300', 1.702, 0, 'TP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2DH001', N'Pate gan Vissan hộp 150g', '14000', 1.556, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2DH002', N'Heo 2 lát Vissan hộp 150g', '26000', 1.548, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2DH003', N'Cá hộp Ba Cô Gái hộp 290g', '22300', 1.549, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2DH004', N'Pate thịt đặc biệt Vissan hộp 170g', '28800', 1.548, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2DH005', N'Cá ngừ ngâm dầu Vissan hộp 120g', '45600', 1.551, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2DK001', N'Xúc xích Vissan 40g', '20500', 1.553, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2DK002', N'Xúc xích CP 40g', '20500', 1.553, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2DK003', N'Snack Oishi Ostar 90g', '11200', 1.556, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2DK004', N'Snack Oishi Swing 90g', '11200', 1.556, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2DK005', N'Snack Oishi bắp 50g', '5600', 1.556, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2DK006', N'Snack Oishi hành 50g', '5600', 1.556, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2DK007', N'Snack Lays 90g', '11200', 1.556, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2DK008', N'Snack Oishi phồng mực 50g', '6500', 1.548, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2BK001', N'Bánh Nabati 300g', '34400', 1.55, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2BK002', N'Bánh gạo An nướng 175g', '25100', 1.549, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2BK003', N'Bánh Chocopie 660g', '65100', 1.55, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2BK004', N'Bánh bông lan Orion 300g', '55800', 1.55, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2BK005', N'Bánh Orion Custas 470g', '89300', 1.55, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2BK006', N'Bánh quy phô mai Gary 270g', '49300', 1.55, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2BK007', N'Kẹo ngậm Ricola 17.5g', '18600', 1.55, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2BK008', N'Kẹo ngậm DoubleMint 35 viên', '27000', 1.552, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2BK009', N'Kẹo Alpenlibe thanh', '7400', 1.542, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2BK010', N'Kẹo Golia thanh', '7400', 1.542, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2MI001', N'Mì Omachi 80g', '7000', 1.556, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP2MI002', N'Mì Hảo Hảo 75g', '3600', 1.538, 0, 'TP2');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP3KE001', N'Kem ốc quế Merino', '18400', 1.704, 0, 'TP3');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP3KE002', N'Kem ốc quế Celano', '19400', 1.702, 0, 'TP3');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP4RC001', N'Bông cải xanh 700g', '56100', 1.7, 0, 'TP4');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP4RC002', N'Cài thìa gói 450g', '20400', 1.7, 0, 'TP4');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP4RC003', N'Khoai tây vàng 400g', '16300', 1.698, 0, 'TP4');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP4RC004', N'Cà rốt Đà Lạt 500g', '15300', 1.7, 0, 'TP4');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP4RC005', N'Cà chua Đà Lạt 500g', '21900', 1.698, 0, 'TP4');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP4RC006', N'Bí đao xanh 500g', '16300', 1.698, 0, 'TP4');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP4RC007', N'Dưa leo 500g', '16300', 1.698, 0, 'TP4');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP4RC008', N'Bí đỏ Đà Lạt 1kg', '11200', 1.697, 0, 'TP4');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP4TC001', N'Cam Mỹ nhập khẩu 1kg', '122400', 1.7, 0, 'TP4');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP4TC002', N'Ổi Đài Loan 1kg', '23500', 1.703, 0, 'TP4');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP4TC003', N'Dưa hấu ruột đỏ 1kg', '16300', 1.698, 0, 'TP4');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP4TC004', N'Xoài keo vàng 1kg', '33700', 1.702, 0, 'TP4');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('TP4TC005', N'Táo Fuji Nam Phi 1kg', '66300', 1.7, 0, 'TP4');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('GV1NC001', N'Nước tương Maggi 700ml', '25100', 1.549, 0, 'GV1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('GV1NC002', N'Nước mắm Nam Ngư 650ml', '51200', 1.552, 0, 'GV1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('GV1NC003', N'Tương ớt Cholimex 270g', '11200', 1.556, 0, 'GV1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('GV1NC004', N'Tương cà Cholimex 270g', '11200', 1.556, 0, 'GV1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('GV1DA001', N'Dầu ăn Simply 1l', '61400', 1.551, 0, 'GV1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('GV1GV001', N'Muối I ốt Vifon 950g', '11200', 1.556, 0, 'GV1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('GV1GV002', N'Bột ngọt Ajinomoto 1kg', '71600', 1.55, 0, 'GV1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('GV1GV003', N'Đường mía Biên Hoà 1kg', '27900', 1.55, 0, 'GV1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('DU1NN001', N'Nước ngọt Cocacola 600ml', '7400', 1.542, 0, 'DU1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('DU1NN002', N'Nước ngọt Pepsi 390ml', '5600', 1.556, 0, 'DU1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('DU1NN003', N'Nước ngọt 7Up lon 320ml', '7000', 1.556, 0, 'DU1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('DU1NN004', N'Nước ngọt Cocacola lon 320ml', '7000', 1.556, 0, 'DU1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('DU1NS001', N'Nước suối Aquafina 500ml', '4700', 1.567, 0, 'DU1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('DU1NS002', N'Nước suối Dasani 500ml', '4200', 1.556, 0, 'DU1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('VP1HT002', N'Tập 96 trang ABC', '5100', 1.545, 0, 'VP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('VP1HT003', N'Bút bi TL-089', '3300', 1.571, 0, 'VP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('VP1HT004', N'Bút lông bàng TL WB003', '10200', 1.545, 0, 'VP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('VP1HT005', N'Bút lông dầu TL PM04', '10200', 1.545, 0, 'VP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('VP1HT006', N'Bút chì gỗ 2B TL', '2800', 1.556, 0, 'VP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('VP1HT007', N'Gôm TL E-05', '4700', 1.567, 0, 'VP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('VP1HT008', N'Bộ thước TL SR-012', '14000', 1.556, 0, 'VP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('VP1HT009', N'Bút sáp màu 10 màu TL CR-C041000', '20500', 1.553, 0, 'VP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('HP1KG001', N'Khăn giấy ướt 120 tờ', '21400', 1.551, 0, 'HP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('HP1KG002', N'Khăn giấy ướt 30 tờ', '11200', 1.556, 0, 'HP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('HP1KG003', N'Khăn giấy lụa 280 tờ', '14900', 1.552, 0, 'HP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('HP1NG001', N'Nước giặt Ariel 3.9kg', '238100', 1.55, 0, 'HP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('HP1NG002', N'Bột giặt Lix 7kg', '167400', 1.55, 0, 'HP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('HP1XB001', N'Sữa tắm Dove 900g', '203700', 1.55, 0, 'HP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('HP1XB002', N'Dầu gội Dove 640g', '133900', 1.55, 0, 'HP1');
INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MALSP) VALUES ('HP1XB003', N'Nước rửa tay Lifebuoy 450g', '70700', 1.55, 0, 'HP1');
go

-- Bảng NHACungcap 
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC001', N'Yorihada', '0901057057', N'469 Nguyễn Hữu Thọ, P.Tân Hưng, Q.7, Tp.HCM', N'SHIN KYUK-HO', '304741634');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC002', N'Vissan', '02835533999 ', N'420 Nơ Trang Long, P.13, Q.Bình Thạnh, Tp.HCM', N'VĂN ĐỨC MƯỜI', '300105356');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC003', N'Royal Food ThaiLand', '0733953695', N'Lô 19-20 Khu Công nghiệp Mỹ Tho, Xã Trung An, Tp.Mỹ Tho, Tiền Giang', N'SURASAK EIAMSUMANG', '1200537749');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC004', N'CP', '02513836251', N'KCN Biên Hòa II, P.Long Bình Tân, Tp.Biên Hoà, Tỉnh Đồng Nai', N'MONTRI SUWANPOSRI', '3600224423');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC005', N'Oishi', '0838219928', N'11A Đường Phan Kế Bính , P.Đa Kao, Q.1, Tp.HCM', N'NONGNUCH BURANASETKUL', '313173064');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC006', N'PepsiCo', '38219437418', N'88 Đồng Khởi , P.Bến Nghé, Q.1, Tp.HCM', N'JAHANZEB QAYUM KHAN', '300816663');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC007', N'Nabati', '', N'16 Nguyễn Trường Tộ, P.13, Q.4', N'ADI SETIAWAN SOETJIPTO', '312049547');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC008', N'Orion', '', N'72 Lê Thánh Tôn, P.Bến Nghé, Q.1, Tp.HCM', N'	NGUYỄN THỊ LÊ', '313589337');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC009', N'GarudaFood', '0288250257', N'132-134 Đồng Khởi, P.Bến Nghé, Q.1, Tp.HCM', N'IRMAN IMAWAN', '301485301');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC010', N'Ricola', '', N'Laufen, Switzerland', N'THOMAS P. MEIER', '316258005');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC011', N'Wrigley', '02835214005', N'Đại học Quốc tế Miền Đông, P.Hoà Phú, Tp.Thủ Dầu Một, Tỉnh Bình Dương', N'LÊ QUANG HẢO', '3701994997');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC012', N'Perfetti Van Melle', '', N'Đường 26, Khu công nghiệp Sóng Thần 2, P.Dĩ An, Tp.Dĩ An, Tỉnh Bình Dương', N'	SHARMA NIKHIL', '3700698272');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC013', N'Masan', '', N'17 Lê Duẩn, P.Bến Nghé, Q.1, Tp.HCM', N'NGUYỄN ĐĂNG QUANG', '302100924');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC014', N'Acecook', '02838154064', N'Đường số 11, Nhóm CN II, Khu Công nghiệp Tân Bình, P.Tây Thạnh, Q.Tân Phú, Tp.HCM', N'KANEDA HIROKI', '300808687');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC015', N'Kido', '', N'138 -142 Hai Bà Trưng, P.Đa Kao, Q.1, Tp.HCM', N'TRẦN KIM THÀNH', '302705302');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC016', N'VietGAP', '0903458023', N'11 Đường số 4, P.Bình Trị Đông B, Q.Bình Tân, Tp.HCM', N'VÕ QUANG SÁNG', '314619626');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC017', N'Nestle', '0288461971', N'Căn hộ số 203 nhà B4b Kim mã, Q.Ba Đình, Hà Nội', N'LƯƠNG VĂN MỸ THIỆN', '500233161');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC018', N'Cholimex Food', '', N'Đường Số 7, Khu công nghiệp Vĩnh Lộc, Xã Vĩnh Lộc A, Huyện Bình Chánh, Tp.HCM', N'	DIỆP NAM HẢI', '304475742');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC019', N'Calofic', '02033846993', N'Cảng Cái Lân, P.Bãi Cháy, Tp.Hạ Long, Tỉnh Quảng Ninh', N'VŨ VĂN PHÚ', '5700101362');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC020', N'VIFON', '02838153933', N'913 Trường Chinh, P.Tây Thạnh, Q.Tân Phú, Tp.HCM', N'LE THI ANH PHUONG', '1101171437');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC021', N'Ajinomoto', '02513831289', N'Khu Công nghiệp Biên Hòa I, P.An Bình, Tp.Biên Hoà, Đồng Nai', N'TSUTOMU NARA', '3602257618');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC022', N'Đường Biên Hoà', '', N'Công ty CP đường Biên Hoà, KCN Biên Hoà I, P.An Bình, Tp.Biên Hoà, Đồng Nai', N'VENKATASIVA RAMA SUBBAIAH KOSA', '3300100811');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC023', N'Coca-Cola', '02835206700', N'235 Đường Đồng Khởi, P.Bến Nghé, Q.1, Tp.HCM', N'NGÔ VĂN HẢI', '315749378');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC024', N'Công ty Đỗ Gia Phát', '0618706038', N'Xã Lộc An, Huyện Long Thành, Tỉnh Đồng Nai', N'	NGUYỄN THỊ HỒNG LIÊN', '3602083898');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC025', N'Tập đoàn Thiên Long', '02837505555', N'10 Đường Mai Chí Thọ, P.Thủ Thiêm, Tp.Thủ Đức, Tp.HCM', N'TRẦN PHƯƠNG NGA', '301464830');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC026', N'L-Choice Lotte', '0941457999', N'272 Võ Chí Công, P.Phú Thượng, Q.Tây Hồ, Hà Nội', N'PARK JAE SUNG', '109149008');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC027', N'P&G', '02435560666', N'74F Yên Phụ, P.Yên Phụ, Q.Tây Hồ, Hà Nội', N'NGUYỄN THU HẰNG', '108481972');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC028', N'Lixco', '02838963658', N'	Số 3 đường số 2, Khu phố 4, P.Linh Trung, Tp.Thủ Đức, Tp.HCM', N'CAO THÀNH TÍN', '301444263');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC029', N'Dove', '0903598636', N'012/T1 An Phú Đông 9, P.An Phú Đông, Q.12, Tp.HCM', N'	NGUYỄN TRỌNG TÍN', '312928604');
INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue) VALUES ('NCC030', N'Lifebuoy Vietnam', '0300762150', N'Khu Công nghiệp Tây Bắc Củ Chi, Xã Tân An Hội, Huyện Củ Chi, Tp.HCM', N'NGUYỄN THỊ BÍCH VÂN', '300762150');
go

-- Bảng NCC_SP
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC001', 'TP1BM001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC001', 'TP1BM002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC001', 'TP1SW001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC001', 'TP1SW002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC001', 'TP1HD001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC001', 'TP1BB001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC001', 'TP1MI001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC001', 'TP1MI002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC001', 'TP1XX001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC002', 'TP2DH001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC002', 'TP2DH002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC002', 'TP2DH004');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC002', 'TP2DH005');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC002', 'TP2DK001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC003', 'TP2DH003');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC004', 'TP2DK002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC005', 'TP2DK003');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC005', 'TP2DK004');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC005', 'TP2DK005');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC005', 'TP2DK006');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC005', 'TP2DK008');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC006', 'TP2DK007');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC006', 'DU1NN002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC006', 'DU1NN003');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC006', 'DU1NS001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC007', 'TP2BK001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC008', 'TP2BK002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC008', 'TP2BK003');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC008', 'TP2BK004');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC008', 'TP2BK005');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC009', 'TP2BK006');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC010', 'TP2BK007');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC011', 'TP2BK008');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC012', 'TP2BK009');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC012', 'TP2BK010');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC013', 'TP2MI001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC013', 'GV1NC002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC014', 'TP2MI002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC015', 'TP3KE001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC015', 'TP3KE002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC016', 'TP4RC001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC016', 'TP4RC002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC016', 'TP4RC003');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC016', 'TP4RC004');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC016', 'TP4RC005');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC016', 'TP4RC006');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC016', 'TP4RC007');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC016', 'TP4RC008');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC016', 'TP4TC001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC016', 'TP4TC002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC016', 'TP4TC003');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC016', 'TP4TC004');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC016', 'TP4TC005');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC017', 'GV1NC001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC018', 'GV1NC003');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC018', 'GV1NC004');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC019', 'GV1DA001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC020', 'GV1GV001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC021', 'GV1GV002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC022', 'GV1GV003');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC023', 'DU1NN001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC023', 'DU1NN004');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC023', 'DU1NS002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC024', 'VP1HT002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC025', 'VP1HT003');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC025', 'VP1HT004');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC025', 'VP1HT005');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC025', 'VP1HT006');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC025', 'VP1HT007');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC025', 'VP1HT008');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC025', 'VP1HT009');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC026', 'HP1KG001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC026', 'HP1KG002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC026', 'HP1KG003');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC027', 'HP1NG001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC028', 'HP1NG002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC029', 'HP1XB001');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC029', 'HP1XB002');
INSERT INTO NCC_SP (MaNCC, MaSP) VALUES ('NCC030', 'HP1XB003');
go

/*
delete from CTHDBH
delete from HDBH
delete from CTHDNH
delete from HDNH
*/

-- Bảng HDNH
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00001', 'NV001', 'NCC001', CAST('2024-04-01 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00002', 'NV001', 'NCC010', CAST('2024-04-01 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00003', 'NV001', 'NCC003', CAST('2024-04-01 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00004', 'NV001', 'NCC002', CAST('2024-04-01 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00005', 'NV002', 'NCC001', CAST('2024-04-08 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00006', 'NV002', 'NCC004', CAST('2024-04-08 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00007', 'NV002', 'NCC026', CAST('2024-04-08 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00008', 'NV002', 'NCC005', CAST('2024-04-08 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00009', 'NV002', 'NCC016', CAST('2024-04-08 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00010', 'NV002', 'NCC019', CAST('2024-04-08 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00011', 'NV002', 'NCC014', CAST('2024-04-08 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00012', 'NV002', 'NCC030', CAST('2024-04-08 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00013', 'NV002', 'NCC006', CAST('2024-04-08 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00014', 'NV004', 'NCC016', CAST('2024-04-15 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00015', 'NV004', 'NCC007', CAST('2024-04-15 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00016', 'NV004', 'NCC024', CAST('2024-04-15 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00017', 'NV004', 'NCC029', CAST('2024-04-15 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00018', 'NV004', 'NCC012', CAST('2024-04-15 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00019', 'NV005', 'NCC001', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00020', 'NV005', 'NCC008', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00021', 'NV005', 'NCC011', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00022', 'NV005', 'NCC009', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00023', 'NV005', 'NCC013', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00024', 'NV005', 'NCC015', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00025', 'NV005', 'NCC025', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00026', 'NV005', 'NCC017', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00027', 'NV005', 'NCC028', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00028', 'NV005', 'NCC021', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00029', 'NV005', 'NCC027', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00030', 'NV005', 'NCC016', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00031', 'NV005', 'NCC018', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00032', 'NV005', 'NCC001', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00033', 'NV005', 'NCC020', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00034', 'NV005', 'NCC023', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00035', 'NV005', 'NCC022', CAST('2024-04-22 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00036', 'NV006', 'NCC001', CAST('2024-04-29 00:00:00' AS smalldatetime), '0');
INSERT INTO HDNH (MaHDNH, MaNV, MaNCC, NgHDNH, TriGia) VALUES ('NH00037', 'NV006', 'NCC013', CAST('2024-04-29 00:00:00' AS smalldatetime), '0');
go

-- Bảng CTHDNH
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00001', 'TP1BM001', '20', CAST('2024-04-05' AS smalldatetime), '12000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00001', 'TP1BM002', '20', CAST('2024-04-05' AS smalldatetime), '15000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00001', 'TP1SW001', '20', CAST('2024-04-05' AS smalldatetime), '13200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00001', 'TP1SW002', '20', CAST('2024-04-05' AS smalldatetime), '16800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00001', 'TP1HD001', '20', CAST('2024-04-05' AS smalldatetime), '10800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00001', 'TP1BB001', '20', CAST('2024-04-05' AS smalldatetime), '7200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00001', 'TP1MI001', '20', CAST('2024-04-05' AS smalldatetime), '15000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00001', 'TP1MI002', '20', CAST('2024-04-05' AS smalldatetime), '18000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00001', 'TP1XX001', '20', CAST('2024-04-05' AS smalldatetime), '8400');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00002', 'TP2BK007', '50', CAST('2025-04-01' AS smalldatetime), '12000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00003', 'TP2DH003', '50', CAST('2025-04-01' AS smalldatetime), '14400');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00004', 'TP2DH001', '50', CAST('2025-04-01' AS smalldatetime), '9000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00004', 'TP2DH002', '50', CAST('2025-04-01' AS smalldatetime), '16800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00004', 'TP2DH004', '50', CAST('2025-04-01' AS smalldatetime), '18600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00004', 'TP2DH005', '50', CAST('2025-04-01' AS smalldatetime), '29400');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00004', 'TP2DK001', '30', CAST('2025-04-01' AS smalldatetime), '13200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00005', 'TP1BM001', '15', CAST('2024-04-12' AS smalldatetime), '12000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00005', 'TP1BM002', '15', CAST('2024-04-12' AS smalldatetime), '15000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00005', 'TP1SW002', '15', CAST('2024-04-12' AS smalldatetime), '16800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00005', 'TP1BB001', '30', CAST('2024-04-12' AS smalldatetime), '7200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00005', 'TP1MI001', '15', CAST('2024-04-12' AS smalldatetime), '15000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00005', 'TP1MI002', '15', CAST('2024-04-12' AS smalldatetime), '18000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00006', 'TP2DK002', '30', CAST('2025-04-12' AS smalldatetime), '13200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00007', 'HP1KG001', '40', CAST('2029-04-12' AS smalldatetime), '13800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00007', 'HP1KG002', '40', CAST('2029-04-12' AS smalldatetime), '7200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00007', 'HP1KG003', '40', CAST('2029-04-12' AS smalldatetime), '9600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00008', 'TP2DK003', '50', CAST('2025-04-12' AS smalldatetime), '7200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00008', 'TP2DK004', '50', CAST('2025-04-12' AS smalldatetime), '7200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00008', 'TP2DK005', '50', CAST('2025-04-12' AS smalldatetime), '3600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00008', 'TP2DK006', '50', CAST('2025-04-12' AS smalldatetime), '3600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00008', 'TP2DK008', '50', CAST('2025-04-12' AS smalldatetime), '4200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00009', 'TP4RC001', '20', CAST('2024-04-15' AS smalldatetime), '33000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00009', 'TP4RC002', '20', CAST('2024-04-15' AS smalldatetime), '12000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00009', 'TP4RC003', '20', CAST('2024-04-15' AS smalldatetime), '9600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00009', 'TP4RC004', '20', CAST('2024-04-15' AS smalldatetime), '9000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00009', 'TP4RC005', '20', CAST('2024-04-15' AS smalldatetime), '12900');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00009', 'TP4RC006', '20', CAST('2024-04-15' AS smalldatetime), '9600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00009', 'TP4RC007', '20', CAST('2024-04-15' AS smalldatetime), '9600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00009', 'TP4RC008', '20', CAST('2024-04-15' AS smalldatetime), '6600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00009', 'TP4TC001', '20', CAST('2024-04-15' AS smalldatetime), '72000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00009', 'TP4TC002', '20', CAST('2024-04-15' AS smalldatetime), '13800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00009', 'TP4TC003', '20', CAST('2024-04-15' AS smalldatetime), '9600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00009', 'TP4TC004', '20', CAST('2024-04-15' AS smalldatetime), '19800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00009', 'TP4TC005', '20', CAST('2024-04-15' AS smalldatetime), '39000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00010', 'GV1DA001', '30', CAST('2025-04-12' AS smalldatetime), '39600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00011', 'TP2MI002', '100', CAST('2025-04-12' AS smalldatetime), '2340');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00012', 'HP1XB003', '25', CAST('2026-04-12' AS smalldatetime), '45600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00013', 'TP2DK007', '30', CAST('2025-04-12' AS smalldatetime), '7200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00013', 'DU1NN002', '80', CAST('2025-04-12' AS smalldatetime), '3600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00013', 'DU1NN003', '80', CAST('2025-04-12' AS smalldatetime), '4500');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00013', 'DU1NS001', '80', CAST('2025-04-12' AS smalldatetime), '3000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00014', 'TP4RC001', '20', CAST('2024-04-22' AS smalldatetime), '33000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00014', 'TP4RC002', '20', CAST('2024-04-22' AS smalldatetime), '12000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00014', 'TP4RC003', '20', CAST('2024-04-22' AS smalldatetime), '9600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00014', 'TP4RC005', '20', CAST('2024-04-22' AS smalldatetime), '12900');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00014', 'TP4RC008', '20', CAST('2024-04-22' AS smalldatetime), '6600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00014', 'TP4TC002', '20', CAST('2024-04-22' AS smalldatetime), '13800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00014', 'TP4TC003', '20', CAST('2024-04-22' AS smalldatetime), '9600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00014', 'TP4TC005', '20', CAST('2024-04-22' AS smalldatetime), '39000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00015', 'TP2BK001', '30', CAST('2025-04-15' AS smalldatetime), '22200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00016', 'VP1HT002', '15', CAST('2025-04-15' AS smalldatetime), '3300');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00017', 'HP1XB001', '25', CAST('2026-04-15' AS smalldatetime), '131400');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00017', 'HP1XB002', '25', CAST('2026-04-15' AS smalldatetime), '86400');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00018', 'TP2BK009', '30', CAST('2025-04-15' AS smalldatetime), '4800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00018', 'TP2BK010', '30', CAST('2025-04-15' AS smalldatetime), '4800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00019', 'TP1BM001', '20', CAST('2024-04-27' AS smalldatetime), '12000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00019', 'TP1BM002', '20', CAST('2024-04-27' AS smalldatetime), '15000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00019', 'TP1SW001', '15', CAST('2024-04-27' AS smalldatetime), '13200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00019', 'TP1SW002', '15', CAST('2024-04-27' AS smalldatetime), '16800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00019', 'TP1HD001', '15', CAST('2024-04-27' AS smalldatetime), '10800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00019', 'TP1BB001', '20', CAST('2024-04-27' AS smalldatetime), '7200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00019', 'TP1MI001', '10', CAST('2024-04-27' AS smalldatetime), '15000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00019', 'TP1MI002', '10', CAST('2024-04-27' AS smalldatetime), '18000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00019', 'TP1XX001', '10', CAST('2024-04-27' AS smalldatetime), '8400');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00020', 'TP2BK002', '25', CAST('2025-04-22' AS smalldatetime), '16200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00020', 'TP2BK003', '25', CAST('2025-04-22' AS smalldatetime), '42000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00020', 'TP2BK004', '25', CAST('2025-04-22' AS smalldatetime), '36000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00020', 'TP2BK005', '25', CAST('2025-04-22' AS smalldatetime), '57600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00021', 'TP2BK008', '25', CAST('2025-04-22' AS smalldatetime), '17400');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00022', 'TP2BK006', '25', CAST('2025-04-22' AS smalldatetime), '31800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00023', 'TP2MI001', '100', CAST('2025-04-22' AS smalldatetime), '4500');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00024', 'TP3KE001', '45', CAST('2025-04-22' AS smalldatetime), '10800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00024', 'TP3KE002', '45', CAST('2025-04-22' AS smalldatetime), '11400');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00025', 'VP1HT003', '15', CAST('' AS smalldatetime), '2100');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00025', 'VP1HT004', '15', CAST('' AS smalldatetime), '6600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00025', 'VP1HT005', '15', CAST('' AS smalldatetime), '6600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00025', 'VP1HT006', '15', CAST('' AS smalldatetime), '1800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00025', 'VP1HT007', '15', CAST('' AS smalldatetime), '3000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00025', 'VP1HT008', '15', CAST('' AS smalldatetime), '9000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00025', 'VP1HT009', '15', CAST('' AS smalldatetime), '13200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00026', 'GV1NC001', '30', CAST('2025-04-22' AS smalldatetime), '16200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00027', 'HP1NG002', '30', CAST('2027-04-22' AS smalldatetime), '108000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00028', 'GV1GV002', '30', CAST('2025-04-22' AS smalldatetime), '46200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00029', 'HP1NG001', '30', CAST('2027-04-22' AS smalldatetime), '153600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00030', 'TP4RC001', '20', CAST('2024-04-29' AS smalldatetime), '33000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00030', 'TP4RC002', '20', CAST('2024-04-29' AS smalldatetime), '12000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00030', 'TP4RC003', '20', CAST('2024-04-29' AS smalldatetime), '9600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00030', 'TP4RC004', '20', CAST('2024-04-29' AS smalldatetime), '9000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00030', 'TP4RC005', '20', CAST('2024-04-29' AS smalldatetime), '12900');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00030', 'TP4RC006', '20', CAST('2024-04-29' AS smalldatetime), '9600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00030', 'TP4RC007', '20', CAST('2024-04-29' AS smalldatetime), '9600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00030', 'TP4RC008', '20', CAST('2024-04-29' AS smalldatetime), '6600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00030', 'TP4TC001', '20', CAST('2024-04-29' AS smalldatetime), '72000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00030', 'TP4TC002', '20', CAST('2024-04-29' AS smalldatetime), '13800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00030', 'TP4TC003', '20', CAST('2024-04-29' AS smalldatetime), '9600');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00030', 'TP4TC004', '20', CAST('2024-04-29' AS smalldatetime), '19800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00030', 'TP4TC005', '20', CAST('2024-04-29' AS smalldatetime), '39000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00031', 'GV1NC003', '30', CAST('2025-04-22' AS smalldatetime), '7200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00031', 'GV1NC004', '30', CAST('2025-04-22' AS smalldatetime), '7200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00032', 'TP1SW001', '25', CAST('2024-04-27' AS smalldatetime), '13200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00032', 'TP1SW002', '25', CAST('2024-04-27' AS smalldatetime), '16800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00033', 'GV1GV001', '30', CAST('2025-04-22' AS smalldatetime), '7200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00034', 'DU1NN001', '60', CAST('2025-04-22' AS smalldatetime), '4800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00034', 'DU1NN004', '60', CAST('2025-04-22' AS smalldatetime), '4500');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00034', 'DU1NS002', '120', CAST('2025-04-22' AS smalldatetime), '2700');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00035', 'GV1GV003', '30', CAST('2025-04-22' AS smalldatetime), '18000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00036', 'TP1BM001', '20', CAST('2024-05-04' AS smalldatetime), '12000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00036', 'TP1BM002', '20', CAST('2024-05-04' AS smalldatetime), '15000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00036', 'TP1SW001', '30', CAST('2024-05-04' AS smalldatetime), '13200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00036', 'TP1SW002', '30', CAST('2024-05-04' AS smalldatetime), '16800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00036', 'TP1HD001', '20', CAST('2024-05-04' AS smalldatetime), '10800');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00036', 'TP1BB001', '20', CAST('2024-05-04' AS smalldatetime), '7200');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00036', 'TP1MI001', '15', CAST('2024-05-04' AS smalldatetime), '15000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00036', 'TP1MI002', '15', CAST('2024-05-04' AS smalldatetime), '18000');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00036', 'TP1XX001', '15', CAST('2024-05-04' AS smalldatetime), '8400');
INSERT INTO CTHDNH (MaHDNH, MaSP, SL, HSD, GiaNhap) VALUES ('NH00037', 'GV1NC002', '30', CAST('2025-04-29' AS smalldatetime), '33000');
go

-- Bảng HDBH
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00001', 'NV001', 'KH001', CAST('2024-04-01 09:43:12' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00002', 'NV001', 'KH006', CAST('2024-04-01 11:05:16' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00004', 'NV002', 'KH019', CAST('2024-04-01 20:10:40' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00005', 'NV001', 'KH002', CAST('2024-04-05 08:50:00' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00006', 'NV006', '', CAST('2024-04-12 08:56:57' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00007', 'NV001', '', CAST('2024-04-12 15:12:40' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00008', 'NV003', '', CAST('2024-04-12 21:25:13' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00009', 'NV004', '', CAST('2024-04-15 09:42:15' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00010', 'NV006', '', CAST('2024-04-15 15:30:12' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00011', 'NV005', '', CAST('2024-04-17 12:56:12' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00012', 'NV006', '', CAST('2024-04-20 09:43:21' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00013', 'NV005', '', CAST('2024-04-20 12:25:21' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00014', 'NV004', '', CAST('2024-04-22 20:50:30' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00015', 'NV002', '', CAST('2024-04-23 17:33:14' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00016', 'NV006', '', CAST('2024-04-23 21:25:00' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00017', 'NV006', '', CAST('2024-04-25 07:20:00' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00018', 'NV002', '', CAST('2024-04-25 16:00:12' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00019', 'NV004', 'KH011', CAST('2024-04-25 19:32:30' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00020', 'NV005', 'KH007', CAST('2024-04-26 13:23:40' AS smalldatetime), '0');
INSERT INTO HDBH (MaHDBH, MaNV, MaKH, NgHDBH, TriGia) VALUES ('BH00021', 'NV003', 'KH016', CAST('2024-04-30 20:20:20' AS smalldatetime), '0');
go

-- Bảng CTHDBH
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00001', 'TP1BM002', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00001', 'TP1SW001', '1.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00001', 'TP2DH004', '3.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00001', 'TP2DH005', '4.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00001', 'TP2DK001', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00001', 'TP2BK001', '1.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00002', 'TP2DK005', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00002', 'DU1NN002', '3.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00002', 'DU1NN003', '1.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00002', 'TP2DK007', '4.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00002', 'TP2MI001', '3.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00004', 'TP4TC005', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00004', 'GV1NC001', '1.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00004', 'TP2DK008', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00004', 'TP2BK001', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00004', 'TP2BK002', '3.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00004', 'TP2BK003', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00005', 'HP1XB002', '1.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00005', 'HP1XB003', '1.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00006', 'VP1HT004', '6.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00007', 'TP1HD001', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00007', 'TP1BB001', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00007', 'TP1MI001', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00008', 'TP4TC001', '0.8');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00008', 'TP4TC002', '0.5');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00008', 'TP4TC003', '0.6');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00008', 'TP4RC002', '0.2');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00008', 'TP4RC003', '0.3');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00008', 'GV1NC002', '1.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00008', 'GV1NC003', '1.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00008', 'TP2BK006', '3.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00008', 'TP2BK007', '3.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00008', 'TP2DK002', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00008', 'TP2DK003', '1.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00009', 'TP2DK004', '1.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00009', 'TP1MI002', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00009', 'TP1XX001', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00010', 'TP2MI001', '20.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00010', 'TP2MI002', '20.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00010', 'TP3KE001', '5.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00011', 'TP4RC008', '0.9');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00012', 'TP4TC001', '0.1');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00013', 'TP4TC002', '0.2');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00013', 'DU1NS001', '15.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00014', 'DU1NS002', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00014', 'VP1HT005', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00014', 'VP1HT006', '1.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00014', 'VP1HT007', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00015', 'HP1NG001', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00015', 'TP4RC003', '0.5');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00015', 'TP4RC004', '0.4');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00016', 'GV1DA001', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00017', 'TP1BM001', '10.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00017', 'TP1SW001', '6.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00017', 'TP1SW002', '4.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00017', 'TP2DH002', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00017', 'TP2DH004', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00017', 'TP2DH005', '3.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00018', 'TP2DK004', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00018', 'TP2DK005', '1.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00019', 'DU1NN003', '12.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00019', 'DU1NN004', '12.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00019', 'TP2MI002', '20.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00020', 'TP4RC005', '0.4');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00020', 'TP4RC006', '0.6');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00020', 'TP4TC002', '1.4');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00020', 'TP4TC003', '0.2');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00020', 'TP2MI001', '12.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00020', 'HP1KG002', '2.0');
INSERT INTO CTHDBH (MaHDBH, MaSP, SL) VALUES ('BH00021', 'TP2MI002', '5.0')
go

-- Bảng KHUYENMAI
INSERT INTO KHUYENMAI (MaKM, TenKM, NgayBD, NgayKT) VALUES ('KM01', N'Khuyến mãi đồ ăn chế biến sẵn', CAST('2024-04-07 00:00:00' AS smalldatetime), CAST('2024-04-10 23:59:59' AS smalldatetime));
INSERT INTO KHUYENMAI (MaKM, TenKM, NgayBD, NgayKT) VALUES ('KM02', N'Khuyến mãi thực phẩm tươi', CAST('2024-04-20 00:00:00' AS smalldatetime), CAST('2024-04-23 23:59:59' AS smalldatetime));
INSERT INTO KHUYENMAI (MaKM, TenKM, NgayBD, NgayKT) VALUES ('KM03', N'Đại hạ giá thực phẩm khô ngày đầu tháng', CAST('2024-04-01 00:00:00' AS smalldatetime), CAST('2024-04-01 23:59:59' AS smalldatetime));
go

--Bảng Chitietkhuyenmai (ptkm : 
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM01', 'TP1BM001', 0.15);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM01', 'TP1BM002', 0.15);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM01', 'TP1SW001', 0.15);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM01', 'TP1SW002', 0.15);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM01', 'TP1HD001', 0.15);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM01', 'TP1BB001', 0.15);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM01', 'TP1MI001', 0.15);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM01', 'TP1MI002', 0.15);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM01', 'TP1XX001', 0.15);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM02', 'TP4RC001', 0.12);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM02', 'TP4RC002', 0.12);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM02', 'TP4RC003', 0.12);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM02', 'TP4RC004', 0.12);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM02', 'TP4RC005', 0.12);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM02', 'TP4RC006', 0.12);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM02', 'TP4RC007', 0.12);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM02', 'TP4RC008', 0.12);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM02', 'TP4TC001', 0.1);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM02', 'TP4TC002', 0.1);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM02', 'TP4TC003', 0.1);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM02', 'TP4TC004', 0.1);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM02', 'TP4TC005', 0.1);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2DH001', 0.35);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2DH002', 0.35);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2DH003', 0.35);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2DH004', 0.35);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2DH005', 0.35);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2DK001', 0.25);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2DK002', 0.25);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2DK003', 0.25);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2DK004', 0.25);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2DK005', 0.25);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2DK006', 0.25);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2DK007', 0.25);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2DK008', 0.25);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2BK001', 0.2);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2BK002', 0.2);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2BK003', 0.2);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2BK004', 0.2);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2BK005', 0.2);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2BK006', 0.2);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2BK007', 0.2);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2BK008', 0.2);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2BK009', 0.2);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2BK010', 0.2);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2MI001', 0.3);
INSERT INTO CTKM (MaKM, MaSp, PTKM) VALUES ('KM03', 'TP2MI002', 0.3);
go

/*
delete from CALV
delete from CTCL
delete from CTHDBH
delete from CTHDNH
delete from CTKM
delete from HDBH
delete from HDNH
delete from KHACHHANG
delete from KHUYENMAI
delete from LOAISP
delete from NCC_SP
delete from NHACC
delete from NHANVIEN
delete from SANPHAM
*/


--Xay dung rang buoc
--R1: Ca làm việc phải từ 4 tiếng trở lên. 
ALTER TABLE CALV ADD CONSTRAINT CK_SoGio check(SoGio >=4)
GO

--R2: Phần trăm khuyến mãi phải lớn hơn 0 và bé hơn 1. 
ALTER TABLE CTKM ADD CONSTRAINT CK_PTKM CHECK(PTKM > 0 and PTKM < 1)
GO

--R3: Ngày kết thúc của chương trình khuyến mãi phải sau ngày bắt đầu của nó. 
ALTER TABLE KHUYENMAI ADD CONSTRAINT CK_KM CHECK(NgayBD < NgayKT)
GO

--R4: Nhân viên phải từ đủ 18 tuổi trở lên mới được nhận vào làm việc. 
ALTER TABLE NHANVIEN ADD CONSTRAINT CK_Age check(YEAR(NGVL) - YEAR(NgSinh) >= 18)
GO

--R5: Trị giá hóa đơn nhập hàng bằng tổng giá bán * số lượng của sản phẩm  
CREATE TRIGGER TRG_R5_1
ON HDNH
AFTER INSERT
AS
BEGIN
	DECLARE @TriGia money, @MaHD char(7)
	SELECT @TriGia = TriGia, @MaHD = MaHDNH FROM inserted
	IF(NOT EXISTS(SELECT * FROM CTHDNH WHERE MaHDNH = @MaHD) and @TriGia <> 0)
	BEGIN
		PRINT N'Không hợp lệ!'
		ROLLBACK TRAN
		RETURN
	END
END
GO

CREATE TRIGGER TRG_R5_2
ON CTHDNH
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @GiaBan money, @MaHD char(7), @SL float, @MaSP char(8), @KM float
	IF(EXISTS(SELECT * FROM inserted))
	BEGIN
		SELECT @MaHD = MaHDNH, @MaSP = MaSP, @SL = SL FROM inserted
		SELECT @GiaBan = GiaBan FROM SANPHAM WHERE MaSP = @MaSP
		UPDATE HDNH
		SET TriGia = TriGia + @SL*@GiaBan
		WHERE MaHDNH = @MaHD
	END
	IF(EXISTS(SELECT * FROM deleted))
	BEGIN
		SELECT @MaHD = MaHDNH, @MaSP = MaSP, @SL = SL FROM inserted
		SELECT @GiaBan = GiaBan FROM SANPHAM WHERE MaSP = @MaSP
		SELECT @KM = PTKM FROM KHUYENMAI a, CTKM b, HDBH c 
		UPDATE HDNH
		SET TriGia = TriGia - @SL*@GiaBan
		WHERE MaHDNH = @MaHD
	END
END
GO

--R6: Trị giá hóa đơn bán hàng bằng tổng giá bán * số lượng của sản phẩm đã trừ đi khuyến mãi
CREATE TRIGGER TRG_R6_1
ON HDBH
AFTER INSERT
AS
BEGIN
	DECLARE @TriGia money, @MaHD char(7)
	SELECT @TriGia = TriGia, @MaHD = MaHDBH FROM inserted
	IF(NOT EXISTS(SELECT * FROM CTHDBH WHERE MaHDBH = @MaHD) and @TriGia <> 0)
	BEGIN
		PRINT N'Không hợp lệ!'
		ROLLBACK TRAN
		RETURN
	END
END
GO

CREATE TRIGGER TRG_R6_2
ON CTHDBH
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @GiaBan money, @MaHD char(7), @SL float, @MaSP char(8), @KM float
	IF(EXISTS(SELECT * FROM inserted))
	BEGIN
		SELECT @MaHD = MaHDBH, @MaSP = MaSP, @SL = SL FROM inserted
		SELECT @GiaBan = GiaBan FROM SANPHAM WHERE MaSP = @MaSP
		SELECT @KM = PTKM FROM KHUYENMAI a, CTKM b, HDBH c 
		WHERE a.MaKM = b.MaKM and MaSP = @MaSP and (c.NgHDBH between NgayBD and NgayKT)
		and c.MaHDBH = @MaHD
		IF(@KM is null)
			SET @KM = 1
		UPDATE HDBH
		SET TriGia = TriGia + @SL*@GiaBan*@KM
		WHERE MaHDBH = @MaHD
	END
	IF(EXISTS(SELECT * FROM deleted))
	BEGIN
		SELECT @MaHD = MaHDBH, @MaSP = MaSP, @SL = SL FROM inserted
		SELECT @GiaBan = GiaBan FROM SANPHAM WHERE MaSP = @MaSP
		SELECT @KM = PTKM FROM KHUYENMAI a, CTKM b, HDBH c 
		WHERE a.MaKM = b.MaKM and MaSP = @MaSP and (c.NgHDBH between NgayBD and NgayKT)
		and c.MaHDBH = @MaHD
		IF(@KM is null)
			SET @KM = 1
		UPDATE HDBH
		SET TriGia = TriGia - @SL*@GiaBan*@KM
		WHERE MaHDBH = @MaHD
	END
END
GO

--R7: Giá bán sản phẩm bằng giá nhập * tỉ lệ xuất nhập (Nếu lấy giá cao chứ không hạ giá) 
CREATE TRIGGER TRG_R7
ON CTHDNH
AFTER INSERT
AS
BEGIN
	DECLARE @MaSP char(8), @GiaNhap money, @TLXN float, @GiaBan money
	SELECT @MaSP = MaSP, @GiaNhap = GiaNhap FROM inserted
	SELECT @GiaBan = GiaBan, @TLXN = TLXN FROM SANPHAM WHERE MaSP = @MaSP
	IF(@GiaNhap * @TLXN > @GiaBan)
	BEGIN
		UPDATE SANPHAM
		SET GiaBan = @GiaNhap * @TLXN
		WHERE MaSP = @MaSP
		RETURN
	END
END
GO

--R8: Ngày lập của hoá đơn nhập hàng phải sau ngày vào làm của nhân viên tạo hoá đơn. 
CREATE TRIGGER TRG_R8_1
ON HDNH
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @MaNV char(5), @NgVL smalldatetime, @NgHD smalldatetime
	SELECT @MaNV = MaNV, @NgHD = NgHDNH FROM inserted
	SELECT @NgVL = NgVL FROM NHANVIEN WHERE MaNV = @MaNV
	IF(@NgVL > @NgHD)
	BEGIN
		PRINT N'Ngày vào làm của nhân viên phải trước ngày lập hoá đơn nhập hàng!'
		ROLLBACK TRAN
		RETURN
	END
END
GO

CREATE TRIGGER TRG_R8_2
ON NHANVIEN
AFTER UPDATE
AS
BEGIN
	DECLARE @MaNV char(5), @NgVL smalldatetime
	SELECT @MaNV = MaNV, @NgVL = NgVL FROM inserted
	IF(NOT EXISTS (SELECT * FROM HDNH WHERE MaNV = @MaNV and NgHDNH < @NgVL))
	BEGIN
		PRINT N'Ngày vào làm của nhân viên phải trước ngày lập hoá đơn nhập hàng!'
		ROLLBACK TRAN
		RETURN
	END
END
GO

--R9: Ngày lập của hoá đơn bán hàng phải sau ngày vào làm của nhân viên tạo hoá đơn.
CREATE TRIGGER TRG_R9_1
ON HDBH
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @MaNV char(5), @NgVL smalldatetime, @NgHD smalldatetime
	SELECT @MaNV = MaNV, @NgHD = NgHDBH FROM inserted
	SELECT @NgVL = NgVL FROM NHANVIEN WHERE MaNV = @MaNV
	IF(@NgVL > @NgHD)
	BEGIN
		PRINT N'Ngày vào làm của nhân viên phải trước ngày lập hoá đơn bán hàng!'
		ROLLBACK TRAN
		RETURN
	END
END
GO

CREATE TRIGGER TRG_R9_2
ON NHANVIEN
AFTER UPDATE
AS
BEGIN
	DECLARE @MaNV char(5), @NgVL smalldatetime
	SELECT @MaNV = MaNV, @NgVL = NgVL FROM inserted
	IF(NOT EXISTS (SELECT * FROM HDBH WHERE MaNV = @MaNV and NgHDBH < @NgVL))
	BEGIN
		PRINT N'Ngày vào làm của nhân viên phải trước ngày lập hoá đơn bán hàng!'
		ROLLBACK TRAN
		RETURN
	END
END
GO

--R10: Số lượng của sản phẩm sản phẩm sẽ thay đổi có sự thay đổi khi có hóa đơn bán  
CREATE TRIGGER TRG_R10_1
ON SANPHAM
AFTER INSERT
AS
BEGIN
	DECLARE @MaSP char(8), @SL float
	SELECT @MaSP = MaSP, @SL = SL FROM inserted
	IF @SL <> 0
	BEGIN
		PRINT N'Chưa nhập hàng, số lượng phải bằng 0'
		ROLLBACK TRAN
		RETURN
	END
END
GO

CREATE TRIGGER TRG_R10_2
ON CTHDNH
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @MASP char(8), @SL float
	IF(EXISTS(SELECT * FROM inserted))
	BEGIN
		SELECT @MaSP = MaSP, @SL = SL FROM inserted
		UPDATE SANPHAM
		SET SL = SL + @SL
		WHERE MaSP = @MASP
	END
	IF(EXISTS(SELECT * FROM deleted))
	BEGIN
		SELECT @MaSP = MaSP, @SL = SL FROM inserted
		UPDATE SANPHAM
		SET SL = SL - @SL
		WHERE MaSP = @MASP
	END
END
GO

CREATE TRIGGER TRG_R10_3
ON CTHDBH
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @MASP char(8), @SL float, @SLCL float
	IF(EXISTS(SELECT * FROM inserted))
	BEGIN
		SELECT @MaSP = MaSP, @SL = SL FROM inserted
		SELECT @SLCL = SL FROM SANPHAM WHERE MaSP = @MASP
		IF(@SL > @SLCL)
		BEGIN
			PRINT N'Số lượng của sản phẩm này không đủ để bán'
			ROLLBACK TRAN
			RETURN
		END
		UPDATE SANPHAM
		SET SL = SL - @SL
		WHERE MaSP = @MASP
	END
	IF(EXISTS(SELECT * FROM deleted))
	BEGIN
		SELECT @MaSP = MaSP, @SL = SL FROM inserted
		UPDATE SANPHAM
		SET SL = SL + @SL
		WHERE MaSP = @MASP
	END
END
GO

--R11: Trong hóa đơn bán hàng nếu MaKH khác NULL thì phải có trong bảng khách hàng
CREATE TRIGGER TRG_R11
ON HDBH
AFTER INSERT
AS
BEGIN
	DECLARE @MaKH char(5)
	SELECT @MaKH = MaKH FROM inserted
	IF(@MaKH IS NOT NULL and NOT EXISTS(SELECT * FROM KHACHHANG WHERE MaKH = @MaKH))
	BEGIN
		PRINT N'MaKH phải có trong danh sách khách hàng là thành viên'
		ROLLBACK TRAN
		RETURN
	END
END
GO

--Xay dung chuc nang
--F1: Tính lương theo tháng của nhân viên
CREATE FUNCTION TINHLUONG(@MaNV char(5), @Thang int, @Nam int) returns money
AS
BEGIN
	IF(NOT EXISTS(SELECT * FROM NHANVIEN WHERE MaNV = @MaNV))
	BEGIN
		RETURN 0
	END
	DECLARE @Luong money, @TongL money
	SELECT @Luong = Luong FROM NHANVIEN WHERE MaNV = @MaNV
	SELECT @TongL = SUM(SoGio * @Luong * (NgayLe + 1)) FROM CTCL, CALV
	WHERE CTCL.MaCa = CALV.MaCa and MaNV = @MaNV and MONTH(GioBD) = @Thang and YEAR(GioBD) = @Nam
	RETURN @TongL
END
GO


--F2: Tính doanh thu theo ngày/tháng/năm
CREATE FUNCTION TINHDT(@Ngay int, @Thang int, @Nam int) returns money
AS
BEGIN
	DECLARE @DT money
	IF(@Ngay <> 0)
	BEGIN
		SELECT @DT = SUM(TriGia) FROM HDBH WHERE DAY(NgHDBH) = @Ngay and MONTH(NgHDBH) = @Thang and YEAR(NgHDBH) = @Nam
		RETURN @DT
	END
	IF(@Thang <> 0)
	BEGIN
		SELECT @DT = SUM(TriGia) FROM HDBH WHERE MONTH(NgHDBH) = @Thang and YEAR(NgHDBH) = @Nam
		RETURN @DT
	END
	IF(@THANG = 0)
	BEGIN
		SELECT @DT = SUM(TriGia) FROM HDBH WHERE YEAR(NgHDBH) = @Nam
		RETURN @DT
	END
	RETURN 0
END
GO

---Stored Procedure
--1 FUNCTION xac dinh gia sau khi khuyen mai

CREATE FUNCTION CalculateDiscountPrice(@MaSP CHAR(8))
RETURNS MONEY
AS
BEGIN
    DECLARE @DiscountPrice MONEY;
    DECLARE @OriginalPrice MONEY;
    DECLARE @DiscountRate FLOAT;
    
    SELECT @OriginalPrice = GiaBan FROM SANPHAM WHERE MaSP = @MaSP;
    SELECT TOP 1 @DiscountRate = PTKM FROM CTKM WHERE MaSP = @MaSP ORDER BY MaKM DESC;
    
    IF @DiscountRate IS NULL
        SET @DiscountPrice = @OriginalPrice;
    ELSE
        SET @DiscountPrice = @OriginalPrice * (1 - @DiscountRate);
    
    RETURN @DiscountPrice;
END;


DECLARE @MaSP CHAR(8) = 'TP2MI001'; 
SELECT dbo.CalculateDiscountPrice(@MaSP) AS DiscountedPrice;


--2 FUNCTION kiem tra hang ton kho

CREATE FUNCTION CheckInventory(@MaLSP CHAR(3))
RETURNS TABLE
AS
RETURN (
    SELECT MaSP, TenSP, SL
    FROM SANPHAM
    WHERE MaLSP = @MaLSP AND SL > 0
);
SELECT * FROM CheckInventory('TP1');

--3 FUNCTION tim kiem nhan vien theo ten

CREATE FUNCTION SearchEmployeeByName(@name NVARCHAR(40))
RETURNS TABLE
AS
RETURN (
    SELECT MaNV, TenNV, NgSinh, GioiTinh, SDT, DiaChi
    FROM NHANVIEN
    WHERE TenNV LIKE '%' + @name + '%'
);

SELECT * FROM dbo.SearchEmployeeByName(N'Nguyễn'); 

--4 FUNCTION tim kiem thong tin khach hang
CREATE FUNCTION SearchCustomerByName(@name NVARCHAR(40))
RETURNS TABLE
AS
RETURN (
    SELECT MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD
    FROM KHACHHANG
    WHERE TenKH LIKE '%' + @name + '%'
);
GO

-- Gọi hàm để kiểm tra
SELECT * FROM dbo.SearchCustomerByName(N'Đỗ'); -- 

--5  Hàm tính tổng giá trị hóa đơn
CREATE FUNCTION CalculateInvoiceTotal(@MaHDBH CHAR(7))
RETURNS MONEY
AS
BEGIN
    DECLARE @Total MONEY;
    
    SELECT @Total = SUM(CTHDBH.SL * SANPHAM.GiaBan)
    FROM CTHDBH
    JOIN SANPHAM ON CTHDBH.MaSP = SANPHAM.MaSP
    WHERE CTHDBH.MaHDBH = @MaHDBH;
    
    RETURN @Total;
END;
GO

-- Gọi hàm để kiểm tra
SELECT dbo.CalculateInvoiceTotal('BH00001'); 
--6 Hàm lấy danh sách sản phẩm theo loại
CREATE FUNCTION GetProductsByCategory(@MaLSP CHAR(3))
RETURNS TABLE
AS
RETURN (
    SELECT MaSP, TenSP, GiaBan, TLXN, SL
    FROM SANPHAM
    WHERE MaLSP = @MaLSP
);
GO

-- Gọi hàm để kiểm tra
SELECT * FROM dbo.GetProductsByCategory('TP2'); 


--STORED PROCEDURE
-- 1 Tạo stored procedure để cập nhật số lượng sản phẩm
CREATE PROCEDURE UpdateProductQuantity
    @MaSP CHAR(8),
    @NewQuantity FLOAT
AS
BEGIN
    UPDATE SANPHAM
    SET SL = @NewQuantity
    WHERE MaSP = @MaSP;
END;
GO


-- Gọi stored procedure để kiểm tra
EXEC UpdateProductQuantity 'TP1BM001', 50; 
--2 Tạo stored procedure để thêm mới khách hàng
CREATE PROCEDURE AddCustomer
    @MaKH CHAR(5),
    @TenKH NVARCHAR(40),
    @NgSinh SMALLDATETIME,
    @GioiTinh BIT,
    @SDT CHAR(10),
    @DiaChi NVARCHAR(100),
    @CCCD VARCHAR(12)
AS
BEGIN
    INSERT INTO KHACHHANG (MaKH, TenKH, NgSinh, GioiTinh, SDT, DiaChi, CCCD)
    VALUES (@MaKH, @TenKH, @NgSinh, @GioiTinh, @SDT, @DiaChi, @CCCD);
END;
GO

-- Gọi stored procedure để kiểm tra
EXEC AddCustomer 'KH111', N'Nguyen Huu Hoang Long', '1980-01-01', 1, '0123456789', N'Hanoi', '123456789012'; 

--3 Tạo stored procedure để thêm mới sản phẩm
CREATE PROCEDURE AddProduct
    @MaSP CHAR(8),
    @TenSP NVARCHAR(100),
    @GiaBan MONEY,
    @TLXN FLOAT,
    @SL FLOAT,
    @MaLSP CHAR(3)
AS
BEGIN
    INSERT INTO SANPHAM (MaSP, TenSP, GiaBan, TLXN, SL, MaLSP)
    VALUES (@MaSP, @TenSP, @GiaBan, @TLXN, @SL, @MaLSP);
END;
GO

-- Gọi stored procedure để kiểm tra
EXEC AddProduct 'TP1BM191', N'KEM FLAN', 15000, 1.5, 32, 'TP4'; 

select* from sanpham
where masp='TP1BM191';

--4 -- Tạo stored procedure để cập nhật thông tin nhân viên
CREATE PROCEDURE UpdateEmployeeInfo
    @MaNV CHAR(5),
    @TenNV NVARCHAR(40),
    @NgSinh SMALLDATETIME,
    @GioiTinh BIT,
    @SDT CHAR(10),
    @DiaChi NVARCHAR(100),
    @NgVL SMALLDATETIME,
    @Luong MONEY
AS
BEGIN
    UPDATE NHANVIEN
    SET TenNV = @TenNV,
        NgSinh = @NgSinh,
        GioiTinh = @GioiTinh,
        SDT = @SDT,
        DiaChi = @DiaChi,
        NgVL = @NgVL,
        Luong = @Luong
    WHERE MaNV = @MaNV;
END;
GO

-- Gọi stored procedure để kiểm tra
EXEC UpdateEmployeeInfo 'NV001', N'Nguyen Le Phuong Thy', '1985-02-02', 1, '0987654321', N'Saigon', '2010-05-05', 50000; 
SELECT* FROM NHANVIEN
WHERE MANV='NV001';

--5  Tạo stored procedure để xóa sản phẩm
CREATE PROCEDURE DeleteProduct
    @MaSP CHAR(8)
AS
BEGIN
    DELETE FROM SANPHAM
    WHERE MaSP = @MaSP;
END;
GO
--6 Tạo stored procedure để thêm mới nhà cung cấp
CREATE PROCEDURE AddSupplier
    @MaNCC CHAR(6),
    @TenNCC NVARCHAR(40),
    @SDT VARCHAR(11),
    @DiaChi NVARCHAR(100),
    @NgDD NVARCHAR(40),
    @MSThue VARCHAR(10)
AS
BEGIN
    INSERT INTO NHACC (MaNCC, TenNCC, SDT, DiaChi, NgDD, MSThue)
    VALUES (@MaNCC, @TenNCC, @SDT, @DiaChi, @NgDD, @MSThue);
END;
GO

-- Gọi stored procedure để kiểm tra
EXEC AddSupplier 'NCC221', N'Công ty A', '0987654321', N'Đà Nẵng', N'Nguyen Van D', '1234567890';
SELECT* FROM NHACC
WHERE MaNCC='NCC221';
