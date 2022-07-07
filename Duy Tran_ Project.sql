--Tìm ra công nhân lãnh lương cao nhất
select distinct
Luong.[MÃ NV],
Luong.[TÊN NV],
Luong.[THÀNH TIỀN / THÁNG_(vnđ)] as "Thu nhập"
from Duy2..Luong as Luong
where Luong.[THÀNH TIỀN / THÁNG_(vnđ)] = (Select max(Luong.[THÀNH TIỀN / THÁNG_(vnđ)]) from Luong)

--Tìm tổng số lượng được sản xuất của từng mã SP
select
Luong.[MÃ SX] as "Mã SP",
Sum(Luong.[SỐ LƯỢNG_(cái)]) as SL
from Luong
group by Luong.[MÃ SX]

--Tìm tổng số lượng được sản xuất của từng nhóm sản phẩm
select
Nhom.[Nhóm ],
Sum(Luong.[SỐ LƯỢNG_(cái)]) as SL
from Luong, Duy2..[Nhóm Sản phẩm] as Nhom
where Luong.[MÃ SX]=Nhom.[Mã SP]
group by Nhom.[Nhóm ] 

--Tính lương bình quân của từng bộ phận
select
BP.[Bộ phận],
AVG(Duy2..Luong.[THÀNH TIỀN / THÁNG_(vnđ)]) as "Luong BQ"
from Duy2..[Bộ phận] as BP, Luong
where Luong.[MÃ NV]=BP.[Mã số NV]
group by BP.[Bộ phận]

--Tính lương bình quân của từng tháng
select distinct
Month(Luong.NGÀY) as Thang,
AVG(Luong.[THÀNH TIỀN / THÁNG_(vnđ)]) as "Luong BQ"
from Duy2..Luong as Luong
group by Month(Luong.NGÀY)
order by Thang ASC

--Tìm ra người lãnh lương cao nhất của từng tháng
with B_Table as (select distinct
MAX(Luong.[THÀNH TIỀN / THÁNG_(vnđ)]) as "Thu nhập",
MONTH(Luong.NGÀY) as Thang
from Duy2..Luong as Luong
group by MONTH(Luong.NGÀY))
select distinct
Duy2..Luong.[MÃ NV],
Duy2..Luong.[TÊN NV],
B_Table.Thang,
B_Table.[Thu nhập]
from B_Table, Duy2..Luong
where B_Table.[Thu nhập]=Duy2..Luong.[THÀNH TIỀN / THÁNG_(vnđ)]

--Tìm ra mã SP được sản xuất ít nhất
with C_Table as (select distinct
Luong.[MÃ SX] as "Mã SP",
Sum(Luong.[SỐ LƯỢNG_(cái)]) as SL
from Luong, Duy2..[Nhóm Sản phẩm]
where Luong.[MÃ SX]=Duy2..[Nhóm Sản phẩm].Mã SX
group by Luong.[MÃ SX])
select
C_Table.SL as SL,
Duy2..[Nhóm Sản phẩm].[Mã SP],
Duy2..[Nhóm Sản phẩm].[Nhóm ]
from C_Table, Duy2..[Nhóm Sản phẩm]
where C_Table.[Mã SP]=Duy2..[Nhóm Sản phẩm].[Mã SP]
and C_Table.SL = (select min(C_Table.SL) from C_Table )

with C_Table as (select distinct
Luong.[MÃ SX] as "Mã SP",
Sum(Luong.[SL THỰC TẾ]) as "SL"
From Duy2..Luong
group by Luong.[MÃ SX])
select
C_Table.[Mã SP],
Duy2..[Nhóm Sản phẩm].[Nhóm ]
from C_Table, Duy2..[Nhóm Sản phẩm]
where C_Table.[Mã SP] = Duy2..[Nhóm Sản phẩm].[Mã SP]
and C_Table.SL=(select min(C_Table.SL) from C_Table)


