USE [master]
GO
/****** Object:  Database [StockManagement]    Script Date: 13-Nov-18 6:41:17 PM ******/
CREATE DATABASE [StockManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StockManagement', FILENAME = N'E:\Dot Net\C#\StockManagementMvcWebApp\newDatabase\StockManagement.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'StockManagement_log', FILENAME = N'E:\Dot Net\C#\StockManagementMvcWebApp\newDatabase\StockManagement_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [StockManagement] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StockManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [StockManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [StockManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [StockManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [StockManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [StockManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [StockManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [StockManagement] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [StockManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [StockManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [StockManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [StockManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [StockManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [StockManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [StockManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [StockManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [StockManagement] SET  DISABLE_BROKER 
GO
ALTER DATABASE [StockManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [StockManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [StockManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [StockManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [StockManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [StockManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [StockManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [StockManagement] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [StockManagement] SET  MULTI_USER 
GO
ALTER DATABASE [StockManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [StockManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [StockManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [StockManagement] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [StockManagement]
GO
/****** Object:  Table [dbo].[CategorySetup]    Script Date: 13-Nov-18 6:41:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CategorySetup](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CategorySetup] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CompanySetup]    Script Date: 13-Nov-18 6:41:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CompanySetup](
	[CompanyId] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CompanySetup] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemSetup]    Script Date: 13-Nov-18 6:41:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ItemSetup](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[CompanyId] [int] NOT NULL,
	[ItemName] [varchar](50) NOT NULL,
	[ReorderLevel] [int] NOT NULL,
	[ItemSold] [float] NULL,
	[ItemDamaged] [float] NULL,
	[ItemLost] [float] NULL,
	[Available] [float] NULL,
 CONSTRAINT [PK_ItemSetup] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StockSetup]    Script Date: 13-Nov-18 6:41:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockSetup](
	[StockId] [int] IDENTITY(1,1) NOT NULL,
	[CompanyId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[StockInQuantity] [float] NULL,
	[StockOutQuantity] [float] NULL,
 CONSTRAINT [PK_StockSetup] PRIMARY KEY CLUSTERED 
(
	[StockId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[ClassRoomAllocationAndClassSchedule]    Script Date: 13-Nov-18 6:41:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ClassRoomAllocationAndClassSchedule]
AS
select c.Code,c.Name as CourseName,b.Name as RoomName,a.Day,a.FromTime,a.ToTime,a.DepartmentID from AllocateClassRoom as a
inner join SaveClassRoom as b
on a.RoomID=b.ID
right join SaveCourse as c
on a.CourseID=c.ID;

GO
/****** Object:  View [dbo].[StockSummary]    Script Date: 13-Nov-18 6:41:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StockSummary]
AS
SELECT        dbo.ItemSetup.ItemName, dbo.CompanySetup.CompanyName, dbo.ItemSetup.Available, dbo.StockSetup.StockInQuantity, dbo.StockSetup.StockOutQuantity, dbo.ItemSetup.ReorderLevel
FROM            dbo.ItemSetup INNER JOIN
                         dbo.CompanySetup ON dbo.ItemSetup.CompanyId = dbo.CompanySetup.CompanyId INNER JOIN
                         dbo.StockSetup ON dbo.ItemSetup.ItemId = dbo.StockSetup.ItemId

GO
/****** Object:  View [dbo].[StudentCourseAssign]    Script Date: 13-Nov-18 6:41:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[StudentCourseAssign] as 
select d.ID as DepartmentID,s.ID,s.RegistrationNo,s.Name,s.Email,d.Name as DepartmentName from SaveStudent as s 
inner join SaveDepartment as d on
s.DepartmentId=d.ID





GO
/****** Object:  View [dbo].[StudentCourseWiseView]    Script Date: 13-Nov-18 6:41:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StudentCourseWiseView]
AS
SELECT        s.StudentID, s.CourseGrade, c.Code, c.Name
FROM            dbo.CourseEnroll AS s LEFT OUTER JOIN
                         dbo.SaveCourse AS c ON s.CourseID = c.ID



GO
/****** Object:  View [dbo].[StudentResultView]    Script Date: 13-Nov-18 6:41:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[StudentResultView] as
select s.StudentID,s.Name,s.Email,s.DepartmentName,s.CourseID,c.Name as CourseName
from CourseEnroll as s left join SaveCourse as c on
s.CourseID=c.ID



GO
/****** Object:  View [dbo].[ViewCourseStatics]    Script Date: 13-Nov-18 6:41:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewCourseStatics]
AS
SELECT c.Code,c.Name,c.DepartmentID,s.Semester,c.Assigned,c.TeacherID from SaveCourse as c
inner join Semesters as s
on c.SemesterID=s.ID


GO
SET IDENTITY_INSERT [dbo].[CategorySetup] ON 

INSERT [dbo].[CategorySetup] ([CategoryId], [CategoryName]) VALUES (1, N'Cosmetics')
INSERT [dbo].[CategorySetup] ([CategoryId], [CategoryName]) VALUES (2, N'Dress')
INSERT [dbo].[CategorySetup] ([CategoryId], [CategoryName]) VALUES (3, N'Ornaments')
SET IDENTITY_INSERT [dbo].[CategorySetup] OFF
SET IDENTITY_INSERT [dbo].[CompanySetup] ON 

INSERT [dbo].[CompanySetup] ([CompanyId], [CompanyName]) VALUES (1, N'Walton')
INSERT [dbo].[CompanySetup] ([CompanyId], [CompanyName]) VALUES (2, N'RFL')
SET IDENTITY_INSERT [dbo].[CompanySetup] OFF
SET IDENTITY_INSERT [dbo].[ItemSetup] ON 

INSERT [dbo].[ItemSetup] ([ItemId], [CategoryId], [CompanyId], [ItemName], [ReorderLevel], [ItemSold], [ItemDamaged], [ItemLost], [Available]) VALUES (1, 2, 2, N'T-Shirt', 1, NULL, NULL, NULL, 10)
INSERT [dbo].[ItemSetup] ([ItemId], [CategoryId], [CompanyId], [ItemName], [ReorderLevel], [ItemSold], [ItemDamaged], [ItemLost], [Available]) VALUES (2, 1, 1, N'Shampoo', 2, NULL, NULL, NULL, 33)
SET IDENTITY_INSERT [dbo].[ItemSetup] OFF
SET IDENTITY_INSERT [dbo].[StockSetup] ON 

INSERT [dbo].[StockSetup] ([StockId], [CompanyId], [ItemId], [StockInQuantity], [StockOutQuantity]) VALUES (21, 2, 2, 12, NULL)
INSERT [dbo].[StockSetup] ([StockId], [CompanyId], [ItemId], [StockInQuantity], [StockOutQuantity]) VALUES (22, 2, 2, 12, NULL)
INSERT [dbo].[StockSetup] ([StockId], [CompanyId], [ItemId], [StockInQuantity], [StockOutQuantity]) VALUES (23, 2, 2, 21, NULL)
INSERT [dbo].[StockSetup] ([StockId], [CompanyId], [ItemId], [StockInQuantity], [StockOutQuantity]) VALUES (24, 1, 1, 10, NULL)
SET IDENTITY_INSERT [dbo].[StockSetup] OFF
ALTER TABLE [dbo].[ItemSetup] ADD  CONSTRAINT [DF_ItemSetup_ReorderLevel]  DEFAULT ((0)) FOR [ReorderLevel]
GO
ALTER TABLE [dbo].[ItemSetup]  WITH CHECK ADD  CONSTRAINT [FK_ItemSetup_CategorySetup] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[CategorySetup] ([CategoryId])
GO
ALTER TABLE [dbo].[ItemSetup] CHECK CONSTRAINT [FK_ItemSetup_CategorySetup]
GO
ALTER TABLE [dbo].[ItemSetup]  WITH CHECK ADD  CONSTRAINT [FK_ItemSetup_CompanySetup] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[CompanySetup] ([CompanyId])
GO
ALTER TABLE [dbo].[ItemSetup] CHECK CONSTRAINT [FK_ItemSetup_CompanySetup]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[35] 4[29] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ItemSetup"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "CompanySetup"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 419
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "StockSetup"
            Begin Extent = 
               Top = 6
               Left = 457
               Bottom = 174
               Right = 641
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StockSummary'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StockSummary'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "s"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 222
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 260
               Bottom = 136
               Right = 430
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StudentCourseWiseView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StudentCourseWiseView'
GO
USE [master]
GO
ALTER DATABASE [StockManagement] SET  READ_WRITE 
GO
