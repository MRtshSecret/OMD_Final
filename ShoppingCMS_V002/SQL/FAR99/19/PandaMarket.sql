USE [PandaMarketCMS]
GO
/****** Object:  Table [dbo].[tbl_Product_PicConnector]    Script Date: 4/7/2020 12:55:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_PicConnector](
	[id_MProduct] [int] NOT NULL,
	[PicID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_UploaderStructure]    Script Date: 4/7/2020 12:55:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_UploaderStructure](
	[PicID] [int] IDENTITY(1,1) NOT NULL,
	[PicCategoryType] [int] NULL,
	[ISDELETE] [tinyint] NULL,
	[alt] [nvarchar](max) NULL,
	[uploadPicName] [nvarchar](max) NULL,
	[Descriptions] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_ADMIN_UploaderStructure] PRIMARY KEY CLUSTERED 
(
	[PicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_UploaderStructure_ImageSize]    Script Date: 4/7/2020 12:55:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_UploaderStructure_ImageSize](
	[picSizeType] [int] IDENTITY(1,1) NOT NULL,
	[picSizeTypeName] [nvarchar](max) NULL,
	[picSizeTypeWidth] [float] NULL,
	[picSizeTypeHeight] [float] NULL,
 CONSTRAINT [PK_tbl_ADMIN_UploaderStructure_ImageSize] PRIMARY KEY CLUSTERED 
(
	[picSizeType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_UploaderStructure_CategoryPic]    Script Date: 4/7/2020 12:55:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_UploaderStructure_CategoryPic](
	[PicCategoryType] [int] IDENTITY(1,1) NOT NULL,
	[PicCategoryTypeName] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_ADMIN_UploaderStructure_CategoryPic] PRIMARY KEY CLUSTERED 
(
	[PicCategoryType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_UploadStructure_ImageAddress]    Script Date: 4/7/2020 12:55:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_UploadStructure_ImageAddress](
	[PicID] [int] NOT NULL,
	[PicSizeType] [int] NOT NULL,
	[PicAddress] [nvarchar](max) NOT NULL,
	[PicThumbnailAddress] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_Images]    Script Date: 4/7/2020 12:55:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Images]
AS
SELECT        dbo.tbl_ADMIN_UploaderStructure_ImageSize.picSizeTypeName, dbo.tbl_ADMIN_UploaderStructure_ImageSize.picSizeTypeWidth, dbo.tbl_ADMIN_UploaderStructure_ImageSize.picSizeTypeHeight, 
                         dbo.tbl_ADMIN_UploadStructure_ImageAddress.PicID, dbo.tbl_ADMIN_UploadStructure_ImageAddress.PicAddress, dbo.tbl_ADMIN_UploadStructure_ImageAddress.PicThumbnailAddress, 
                         dbo.tbl_ADMIN_UploaderStructure_CategoryPic.PicCategoryTypeName, dbo.tbl_ADMIN_UploaderStructure.alt, dbo.tbl_ADMIN_UploaderStructure.uploadPicName, dbo.tbl_ADMIN_UploaderStructure.ISDELETE, 
                         dbo.tbl_ADMIN_UploaderStructure.Descriptions, dbo.tbl_Product_PicConnector.id_MProduct
FROM            dbo.tbl_ADMIN_UploadStructure_ImageAddress INNER JOIN
                         dbo.tbl_ADMIN_UploaderStructure_ImageSize ON dbo.tbl_ADMIN_UploadStructure_ImageAddress.PicSizeType = dbo.tbl_ADMIN_UploaderStructure_ImageSize.picSizeType INNER JOIN
                         dbo.tbl_ADMIN_UploaderStructure ON dbo.tbl_ADMIN_UploadStructure_ImageAddress.PicID = dbo.tbl_ADMIN_UploaderStructure.PicID INNER JOIN
                         dbo.tbl_ADMIN_UploaderStructure_CategoryPic ON dbo.tbl_ADMIN_UploaderStructure.PicCategoryType = dbo.tbl_ADMIN_UploaderStructure_CategoryPic.PicCategoryType LEFT OUTER JOIN
                         dbo.tbl_Product_PicConnector ON dbo.tbl_ADMIN_UploaderStructure.PicID = dbo.tbl_Product_PicConnector.PicID
GO
/****** Object:  Table [dbo].[About]    Script Date: 4/7/2020 12:55:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[About](
	[id_About] [int] IDENTITY(1,1) NOT NULL,
	[Image] [nvarchar](max) NULL,
	[Title_one] [nvarchar](max) NULL,
	[Text_one] [nvarchar](max) NULL,
	[Title_two] [nvarchar](max) NULL,
	[Text_two] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdminTbl]    Script Date: 4/7/2020 12:55:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminTbl](
	[AdminId] [int] IDENTITY(1,1) NOT NULL,
	[AdminName] [nvarchar](100) NULL,
 CONSTRAINT [PK_AdminTbl] PRIMARY KEY CLUSTERED 
(
	[AdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[companies]    Script Date: 4/7/2020 12:55:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[companies](
	[id_companies] [int] IDENTITY(1,1) NOT NULL,
	[Image] [nvarchar](max) NULL,
	[Name_companies] [nvarchar](max) NULL,
	[Url] [nvarchar](max) NULL,
	[Is_delete] [tinyint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpinionAbout]    Script Date: 4/7/2020 12:55:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpinionAbout](
	[Id_OpinionAbout] [int] IDENTITY(1,1) NOT NULL,
	[Name_OpinionAbout] [nvarchar](max) NULL,
	[OpinionAbout] [nvarchar](max) NULL,
	[Is_delete] [tinyint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rules]    Script Date: 4/7/2020 12:55:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rules](
	[id_Rules] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Text] [nvarchar](max) NULL,
	[Is_Desabled] [tinyint] NULL,
	[Is_Delete] [tinyint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_adminMode]    Script Date: 4/7/2020 12:55:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_adminMode](
	[AdminModeID] [int] IDENTITY(1,1) NOT NULL,
	[adminModeName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_ADMIN_adminMode] PRIMARY KEY CLUSTERED 
(
	[AdminModeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_main]    Script Date: 4/7/2020 12:55:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_main](
	[id_Admin] [int] IDENTITY(1,1) NOT NULL,
	[ad_typeID] [int] NOT NULL,
	[ad_username] [nvarchar](max) NULL,
	[ad_password] [nvarchar](max) NULL,
	[ad_firstname] [nvarchar](100) NULL,
	[ad_lastname] [nvarchar](200) NULL,
	[ad_avatarprofile] [nvarchar](max) NULL,
	[ad_email] [nvarchar](max) NULL,
	[ad_phone] [nvarchar](20) NULL,
	[ad_mobile] [nvarchar](20) NULL,
	[ad_has2stepSecurity] [tinyint] NOT NULL,
	[ad_isActive] [tinyint] NOT NULL,
	[ad_isDelete] [tinyint] NOT NULL,
	[ad_lastseen] [datetime] NULL,
	[ad_lastlogin] [datetime] NULL,
	[ad_loginIP] [nvarchar](50) NULL,
	[ad_regdate] [datetime] NOT NULL,
	[ad_personalColorHexa] [nvarchar](max) NULL,
	[AdminModeID] [int] NULL,
	[ad_NickName] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_ADMIN_main] PRIMARY KEY CLUSTERED 
(
	[id_Admin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_ruleRoutes_Category]    Script Date: 4/7/2020 12:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_ruleRoutes_Category](
	[CatId] [int] IDENTITY(1,1) NOT NULL,
	[R_CatName] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_ADMIN_ruleRoutes_Category] PRIMARY KEY CLUSTERED 
(
	[CatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_ruleRoutes_Main]    Script Date: 4/7/2020 12:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_ruleRoutes_Main](
	[rulerouteID] [int] IDENTITY(1,1) NOT NULL,
	[ruleRouteURL] [nvarchar](max) NOT NULL,
	[ruleRouteName] [nvarchar](max) NULL,
	[ruleRouteCatId] [int] NOT NULL,
 CONSTRAINT [PK_tbl_ADMIN_ruleRoutes_Main] PRIMARY KEY CLUSTERED 
(
	[rulerouteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_types]    Script Date: 4/7/2020 12:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_types](
	[ad_typeID] [int] IDENTITY(1,1) NOT NULL,
	[ad_type_name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_tbl_ADMIN_types] PRIMARY KEY CLUSTERED 
(
	[ad_typeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_types_ruleRoute_Connection]    Script Date: 4/7/2020 12:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_types_ruleRoute_Connection](
	[ad_typeID] [int] NOT NULL,
	[rulerouteID] [int] NOT NULL,
	[HasAccess] [tinyint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Categories]    Script Date: 4/7/2020 12:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[Is_Disabled] [tinyint] NULL,
	[Is_Deleted] [tinyint] NULL,
 CONSTRAINT [PK_Categories_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Comment]    Script Date: 4/7/2020 12:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Comment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](max) NULL,
	[message] [nvarchar](max) NULL,
	[Name] [nvarchar](100) NULL,
	[PostId] [int] NULL,
	[ImagePath] [nvarchar](max) NULL,
	[ImageValue] [varbinary](max) NULL,
	[Date] [int] NULL,
 CONSTRAINT [PK_Comment_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_CustomersMessge]    Script Date: 4/7/2020 12:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_CustomersMessge](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NULL,
	[Job] [nvarchar](max) NULL,
	[message] [nvarchar](max) NULL,
	[star] [int] NULL,
	[ImagePath] [nvarchar](max) NULL,
	[ImageValue] [varbinary](max) NULL,
 CONSTRAINT [PK_CustomersMessge_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_EmailModule]    Script Date: 4/7/2020 12:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_EmailModule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmailAddress] [nvarchar](max) NULL,
 CONSTRAINT [PK_EmailModule_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_EmailTemplate]    Script Date: 4/7/2020 12:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_EmailTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemplateName] [nvarchar](50) NULL,
	[HtmlCode] [nvarchar](max) NULL,
 CONSTRAINT [PK_EmailTemplate_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Groups]    Script Date: 4/7/2020 12:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Groups](
	[G_Id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[Is_Disabled] [tinyint] NULL,
	[Is_Deleted] [tinyint] NULL,
 CONSTRAINT [PK_Groups_tbl] PRIMARY KEY CLUSTERED 
(
	[G_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Pic_Connector]    Script Date: 4/7/2020 12:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Pic_Connector](
	[PostId] [int] NOT NULL,
	[PicId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Post]    Script Date: 4/7/2020 12:55:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Post](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Text_min] [nvarchar](max) NULL,
	[Text] [nvarchar](max) NULL,
	[WrittenBy_AdminId] [int] NULL,
	[Date] [datetime] NULL,
	[weight] [int] NULL,
	[IsImportant] [tinyint] NULL,
	[Is_Deleted] [tinyint] NULL,
	[Is_Disabled] [tinyint] NULL,
	[Cat_Id] [int] NULL,
	[GroupId] [int] NULL,
 CONSTRAINT [PK_Post_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Reply]    Script Date: 4/7/2020 12:55:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Reply](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](max) NULL,
	[Name] [nvarchar](100) NULL,
	[Message] [nvarchar](max) NULL,
	[commentId] [int] NULL,
	[ImagePath] [nvarchar](max) NULL,
	[ImageValue] [varbinary](max) NULL,
	[Date] [int] NULL,
 CONSTRAINT [PK_Reply_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_TagConnector]    Script Date: 4/7/2020 12:55:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_TagConnector](
	[Post_Id] [int] NOT NULL,
	[Tag_Id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Tags]    Script Date: 4/7/2020 12:55:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Tags](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[CtegoryId] [int] NULL,
	[Is_Disabled] [tinyint] NULL,
	[Is_Deleted] [tinyint] NULL,
 CONSTRAINT [PK_Tags_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_TeamMembers]    Script Date: 4/7/2020 12:55:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_TeamMembers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Job] [nvarchar](100) NULL,
	[Tozihat] [nvarchar](max) NULL,
	[github] [nvarchar](max) NULL,
	[Linkedin] [nvarchar](max) NULL,
	[Instagram] [nvarchar](max) NULL,
	[ImagePath] [nvarchar](max) NULL,
	[ImageValue] [varbinary](max) NULL,
 CONSTRAINT [PK_TeamMembers_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Customer_Address]    Script Date: 4/7/2020 12:55:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Customer_Address](
	[id_CAddress] [int] IDENTITY(1,1) NOT NULL,
	[id_Customer] [int] NOT NULL,
	[ID_Shahr] [int] NOT NULL,
	[C_AddressHint] [nvarchar](max) NOT NULL,
	[C_FullAddress] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_Customer_Address] PRIMARY KEY CLUSTERED 
(
	[id_CAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Customer_Main]    Script Date: 4/7/2020 12:55:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Customer_Main](
	[id_Customer] [int] IDENTITY(1,1) NOT NULL,
	[C_regDate] [datetime] NOT NULL,
	[C_Mobile] [nvarchar](max) NOT NULL,
	[C_FirstName] [nvarchar](max) NULL,
	[C_LastNAme] [nvarchar](max) NULL,
	[C_Description] [nvarchar](max) NULL,
	[C_ISActivate] [int] NULL,
	[C_ActivationToken] [int] NULL,
	[C_ActivateDate] [datetime] NULL,
	[C_Password] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_Customer_Main] PRIMARY KEY CLUSTERED 
(
	[id_Customer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Enum_Shahr]    Script Date: 4/7/2020 12:55:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Enum_Shahr](
	[ID_Shahr] [int] NULL,
	[Shahr_Name] [nvarchar](max) NULL,
	[Shahr_OstanConnection] [int] NULL,
	[Ostan_name] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product]    Script Date: 4/7/2020 12:55:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product](
	[id_MProduct] [int] IDENTITY(1,1) NOT NULL,
	[IS_AVAILABEL] [tinyint] NOT NULL,
	[id_CreatedByAdmin] [int] NOT NULL,
	[id_DraftLevel] [int] NULL,
	[id_Type] [int] NOT NULL,
	[id_MainCategory] [int] NOT NULL,
	[id_SubCategory] [int] NOT NULL,
	[idMPC_WhichTomainPrice] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[DateCreated] [datetime] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Seo_Description] [nvarchar](max) NOT NULL,
	[Seo_KeyWords] [nvarchar](max) NOT NULL,
	[IS_AD] [tinyint] NOT NULL,
	[Search_Gravity] [int] NOT NULL,
	[Is_IntheDraft] [tinyint] NOT NULL,
	[ISDELETE] [tinyint] NOT NULL,
 CONSTRAINT [PK_tbl_Product] PRIMARY KEY CLUSTERED 
(
	[id_MProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_ConnectorSCOK_Product]    Script Date: 4/7/2020 12:55:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_ConnectorSCOK_Product](
	[id_MProduct] [int] NOT NULL,
	[id_SCOK] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_connectorToMPC_SCOV]    Script Date: 4/7/2020 12:55:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_connectorToMPC_SCOV](
	[id_MPC] [int] NOT NULL,
	[id_SCOV] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_MainCategory]    Script Date: 4/7/2020 12:55:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_MainCategory](
	[id_MC] [int] IDENTITY(1,1) NOT NULL,
	[id_PT] [int] NOT NULL,
	[MCName] [nvarchar](max) NOT NULL,
	[ISDESABLED] [tinyint] NULL,
	[ISDelete] [tinyint] NULL,
	[DateDesabled] [datetime] NULL,
	[DateDeleted] [datetime] NULL,
 CONSTRAINT [PK_tbl_Product_MainCategory] PRIMARY KEY CLUSTERED 
(
	[id_MC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_MainStarTags]    Script Date: 4/7/2020 12:55:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_MainStarTags](
	[id_MainStarTag] [int] IDENTITY(1,1) NOT NULL,
	[MST_Description] [nvarchar](max) NOT NULL,
	[MST_Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_Product_MainStarTags] PRIMARY KEY CLUSTERED 
(
	[id_MainStarTag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_MoneyType]    Script Date: 4/7/2020 12:55:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_MoneyType](
	[MoneyId] [int] IDENTITY(1,1) NOT NULL,
	[MoneyTypeName] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_Product_MoneyType] PRIMARY KEY CLUSTERED 
(
	[MoneyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_OffType]    Script Date: 4/7/2020 12:55:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_OffType](
	[OffType] [int] NOT NULL,
	[OffType_Description] [nvarchar](max) NOT NULL,
	[OffType_Symbol] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_Product_OffType] PRIMARY KEY CLUSTERED 
(
	[OffType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_Opinion]    Script Date: 4/7/2020 12:55:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_Opinion](
	[id_Opinion] [int] IDENTITY(1,1) NOT NULL,
	[id_MProduct] [int] NOT NULL,
	[id_Customer] [int] NOT NULL,
	[id_AccByAdmin] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
	[DateAccepted] [datetime] NULL,
	[Is_Accepted] [tinyint] NOT NULL,
	[OpinionDescription] [nvarchar](max) NOT NULL,
	[Rate] [int] NOT NULL,
	[ISDELETE] [tinyint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_PastProductHistory]    Script Date: 4/7/2020 12:55:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_PastProductHistory](
	[id_PPH] [int] IDENTITY(1,1) NOT NULL,
	[id_MPC] [int] NOT NULL,
	[PriceXquantity] [int] NOT NULL,
	[PricePerquantity] [int] NOT NULL,
	[PriceOff] [int] NULL,
	[OffType] [int] NULL,
	[id_MainStarTag] [int] NOT NULL,
	[ChangedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_Product_PastProductHistory] PRIMARY KEY CLUSTERED 
(
	[id_PPH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_Pic]    Script Date: 4/7/2020 12:55:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_Pic](
	[PicID] [int] IDENTITY(1,1) NOT NULL,
	[id_MProduct] [int] NOT NULL,
	[BigPicAddress] [nvarchar](max) NOT NULL,
	[ThumbnailPicAddress] [nvarchar](max) NOT NULL,
	[ISDELETE] [tinyint] NULL,
	[alt] [nvarchar](max) NULL,
	[uploadPicName] [nvarchar](max) NULL,
	[Descriptions] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_Product_Pic] PRIMARY KEY CLUSTERED 
(
	[PicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_PriceHistory]    Script Date: 4/7/2020 12:55:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_PriceHistory](
	[H_price_id] [int] IDENTITY(1,1) NOT NULL,
	[MPro_Id] [int] NOT NULL,
	[Id_MPc] [int] NOT NULL,
	[PriceXquantity] [bigint] NULL,
	[PricePerquantity] [bigint] NULL,
	[Quantity] [int] NULL,
	[PriceOff] [bigint] NULL,
	[Pricing_Date] [datetime] NULL,
 CONSTRAINT [PK_tbl_Product_PriceHistory] PRIMARY KEY CLUSTERED 
(
	[H_price_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_PriceShow]    Script Date: 4/7/2020 12:55:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_PriceShow](
	[PriceShowId] [int] IDENTITY(1,1) NOT NULL,
	[PriceShowformat] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_Product_PriceShow] PRIMARY KEY CLUSTERED 
(
	[PriceShowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_ProductQuantityType]    Script Date: 4/7/2020 12:55:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_ProductQuantityType](
	[id_PQT] [int] IDENTITY(1,1) NOT NULL,
	[PQT_Description] [nvarchar](max) NULL,
	[PQT_Demansion] [nvarchar](10) NOT NULL,
	[PQT_Quantom] [int] NOT NULL,
 CONSTRAINT [PK_tbl_Product_ProductQuantityType] PRIMARY KEY CLUSTERED 
(
	[id_PQT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_SubCategory]    Script Date: 4/7/2020 12:55:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_SubCategory](
	[id_SC] [int] IDENTITY(1,1) NOT NULL,
	[id_MC] [int] NOT NULL,
	[SCName] [nvarchar](max) NOT NULL,
	[ISDESABLED] [tinyint] NULL,
	[ISDelete] [tinyint] NULL,
	[DateDesabled] [datetime] NULL,
	[DateDeleted] [datetime] NULL,
 CONSTRAINT [PK_tbl_Product_SubCategory] PRIMARY KEY CLUSTERED 
(
	[id_SC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_SubCategoryOptionKey]    Script Date: 4/7/2020 12:55:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_SubCategoryOptionKey](
	[id_SCOK] [int] IDENTITY(1,1) NOT NULL,
	[id_SC] [int] NOT NULL,
	[SCOKName] [nvarchar](max) NOT NULL,
	[ISDESABLED] [tinyint] NULL,
	[ISDelete] [tinyint] NULL,
	[DateDesabled] [datetime] NULL,
	[DateDeleted] [datetime] NULL,
 CONSTRAINT [PK_tbl_Product_SubCategoryKey] PRIMARY KEY CLUSTERED 
(
	[id_SCOK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_SubCategoryOptionValue]    Script Date: 4/7/2020 12:55:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_SubCategoryOptionValue](
	[id_SCOV] [int] IDENTITY(1,1) NOT NULL,
	[id_SCOK] [int] NOT NULL,
	[SCOVValueName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_Product_SubCategoryOptionValue] PRIMARY KEY CLUSTERED 
(
	[id_SCOV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_tagConnector]    Script Date: 4/7/2020 12:55:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_tagConnector](
	[id_MPC] [int] NOT NULL,
	[id_TE] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_TagEnums]    Script Date: 4/7/2020 12:55:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_TagEnums](
	[id_TE] [int] IDENTITY(1,1) NOT NULL,
	[TE_name] [nvarchar](max) NOT NULL,
	[SubCatId] [int] NOT NULL,
 CONSTRAINT [PK_tbl_Product_TagEnums] PRIMARY KEY CLUSTERED 
(
	[id_TE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_tblOptions]    Script Date: 4/7/2020 12:55:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_tblOptions](
	[id_Op] [int] IDENTITY(1,1) NOT NULL,
	[id_MProduct] [int] NOT NULL,
	[KeyName] [nvarchar](max) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_Product_tblOptions] PRIMARY KEY CLUSTERED 
(
	[id_Op] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_Type]    Script Date: 4/7/2020 12:55:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_Type](
	[id_PT] [int] IDENTITY(1,1) NOT NULL,
	[PTname] [nvarchar](max) NOT NULL,
	[ISDESABLED] [tinyint] NULL,
	[ISDelete] [tinyint] NULL,
	[DateDesabled] [datetime] NULL,
	[DateDeleted] [datetime] NULL,
 CONSTRAINT [PK_tbl_Product_Type] PRIMARY KEY CLUSTERED 
(
	[id_PT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_SecurityQuestionEnums]    Script Date: 4/7/2020 12:55:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SecurityQuestionEnums](
	[idSecurityQuestion] [int] IDENTITY(1,1) NOT NULL,
	[Question] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_SecurityQuestionEnums] PRIMARY KEY CLUSTERED 
(
	[idSecurityQuestion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_SecurityQuestionUserAns]    Script Date: 4/7/2020 12:55:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SecurityQuestionUserAns](
	[id_User] [int] NOT NULL,
	[userTypesID] [int] NOT NULL,
	[idSecurityQuestion] [int] NOT NULL,
	[userANS] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_UserController_UserTypes]    Script Date: 4/7/2020 12:55:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_UserController_UserTypes](
	[UserTypeID] [int] IDENTITY(1,1) NOT NULL,
	[UserTypeName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_UserController_UserTypes] PRIMARY KEY CLUSTERED 
(
	[UserTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlb_Product_MainProductConnector]    Script Date: 4/7/2020 12:55:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlb_Product_MainProductConnector](
	[id_MPC] [int] IDENTITY(1,1) NOT NULL,
	[id_MProduct] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[PriceXquantity] [bigint] NOT NULL,
	[PricePerquantity] [bigint] NOT NULL,
	[PriceOff] [bigint] NULL,
	[offTypeValue] [bigint] NULL,
	[OffType] [int] NULL,
	[id_MainStarTag] [int] NOT NULL,
	[ISDELETE] [tinyint] NULL,
	[OutOfStock] [tinyint] NULL,
	[id_PQT] [int] NULL,
	[DateToRelease] [datetime] NULL,
	[PriceModule] [int] NULL,
	[PriceShow] [int] NULL,
	[describtion] [nvarchar](max) NULL,
 CONSTRAINT [PK_tlb_Product_ConnectorToMainProductID] PRIMARY KEY CLUSTERED 
(
	[id_MPC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AdminTbl] ON 

INSERT [dbo].[AdminTbl] ([AdminId], [AdminName]) VALUES (1, N'Niky')
SET IDENTITY_INSERT [dbo].[AdminTbl] OFF
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_main] ON 

INSERT [dbo].[tbl_ADMIN_main] ([id_Admin], [ad_typeID], [ad_username], [ad_password], [ad_firstname], [ad_lastname], [ad_avatarprofile], [ad_email], [ad_phone], [ad_mobile], [ad_has2stepSecurity], [ad_isActive], [ad_isDelete], [ad_lastseen], [ad_lastlogin], [ad_loginIP], [ad_regdate], [ad_personalColorHexa], [AdminModeID], [ad_NickName]) VALUES (2, 1, N'niky', N'12345', N'فاطمه', N'نیک آیین', N'/assets/photo_2019-10-25_15-12-56.jpg', N'niky@gmail.com', N'09123456789', N'0912345678', 1, 1, 0, CAST(N'2020-02-28T13:58:10.660' AS DateTime), CAST(N'2020-02-28T13:58:10.660' AS DateTime), N'1.1.1.1', CAST(N'2020-02-28T13:58:10.660' AS DateTime), N'1', 1, N'niky')
INSERT [dbo].[tbl_ADMIN_main] ([id_Admin], [ad_typeID], [ad_username], [ad_password], [ad_firstname], [ad_lastname], [ad_avatarprofile], [ad_email], [ad_phone], [ad_mobile], [ad_has2stepSecurity], [ad_isActive], [ad_isDelete], [ad_lastseen], [ad_lastlogin], [ad_loginIP], [ad_regdate], [ad_personalColorHexa], [AdminModeID], [ad_NickName]) VALUES (10, 1, N'admin', N'94579457', N'محمد', N'باقری', N'<div class="col-xl-3 col-lg-3 col-md-3"><div class="kt-portlet"><div class="kt-portlet__body"><div class="kt-widget__files"><div class="kt-widget__media"><img class="kt-widget__img" style="height:200px;width:200px;" src="https://localhost:44336/images/a3987f06-9baf-43ac-867d-c0007c6e7ad8-7026128-purple-lines.jpg" alt="image"></div><input style="width:50px;height:50px;background-color:transparent; border:none;" type="text" value="https://localhost:44336/images/a3987f06-9baf-43ac-867d-c0007c6e7ad8-7026128-purple-lines.jpg" id="img578392031" readonly><button onclick="return copytoclipboard(''info_data'',''https://localhost:44336/images/a3987f06-9baf-43ac-867d-c0007c6e7ad8-7026128-purple-lines.jpg'')" class="w-100 btn btn-success">کپی کردن آدرس تصویر</button></div></div></div></div>', N'mohammad@gmail.com', N'091223333', N'021-111111', 1, 1, 1, CAST(N'2020-03-06T11:56:25.033' AS DateTime), CAST(N'2020-03-06T11:56:25.033' AS DateTime), N'123688423', CAST(N'2020-03-06T11:56:25.033' AS DateTime), N'555455', 1, N'ممد')
INSERT [dbo].[tbl_ADMIN_main] ([id_Admin], [ad_typeID], [ad_username], [ad_password], [ad_firstname], [ad_lastname], [ad_avatarprofile], [ad_email], [ad_phone], [ad_mobile], [ad_has2stepSecurity], [ad_isActive], [ad_isDelete], [ad_lastseen], [ad_lastlogin], [ad_loginIP], [ad_regdate], [ad_personalColorHexa], [AdminModeID], [ad_NickName]) VALUES (11, 1, N'1', N'1', N'1', N'1', N'https://image.flaticon.com/icons/svg/1998/1998657.svg', N'1', N'1', N'1', 1, 0, 0, NULL, NULL, NULL, CAST(N'2020-03-10T16:04:43.153' AS DateTime), N'#563d7c', NULL, N'1')
INSERT [dbo].[tbl_ADMIN_main] ([id_Admin], [ad_typeID], [ad_username], [ad_password], [ad_firstname], [ad_lastname], [ad_avatarprofile], [ad_email], [ad_phone], [ad_mobile], [ad_has2stepSecurity], [ad_isActive], [ad_isDelete], [ad_lastseen], [ad_lastlogin], [ad_loginIP], [ad_regdate], [ad_personalColorHexa], [AdminModeID], [ad_NickName]) VALUES (12, 1, N'1', N'1', N'محمد', N'باقری', N'https://image.flaticon.com/icons/svg/1998/1998657.svg', N'1', N'1', N'1', 1, 0, 0, NULL, NULL, NULL, CAST(N'2020-03-10T16:14:21.580' AS DateTime), N'#563d7c', NULL, N'1')
INSERT [dbo].[tbl_ADMIN_main] ([id_Admin], [ad_typeID], [ad_username], [ad_password], [ad_firstname], [ad_lastname], [ad_avatarprofile], [ad_email], [ad_phone], [ad_mobile], [ad_has2stepSecurity], [ad_isActive], [ad_isDelete], [ad_lastseen], [ad_lastlogin], [ad_loginIP], [ad_regdate], [ad_personalColorHexa], [AdminModeID], [ad_NickName]) VALUES (13, 3, N'1', N'1', N'1', N'1', N'https://image.flaticon.com/icons/svg/1998/1998657.svg', N'1', N'1', N'1', 1, 0, 0, NULL, NULL, NULL, CAST(N'2020-03-10T16:18:22.467' AS DateTime), N'#563d7c', NULL, N'1')
INSERT [dbo].[tbl_ADMIN_main] ([id_Admin], [ad_typeID], [ad_username], [ad_password], [ad_firstname], [ad_lastname], [ad_avatarprofile], [ad_email], [ad_phone], [ad_mobile], [ad_has2stepSecurity], [ad_isActive], [ad_isDelete], [ad_lastseen], [ad_lastlogin], [ad_loginIP], [ad_regdate], [ad_personalColorHexa], [AdminModeID], [ad_NickName]) VALUES (14, 4, N'lpln', N'1', N'1', N'1', N'https://image.flaticon.com/icons/svg/1998/1998657.svg', N'1', N'1', N'1', 1, 0, 0, NULL, NULL, NULL, CAST(N'2020-03-10T16:19:25.797' AS DateTime), N'#563d7c', NULL, N'1')
INSERT [dbo].[tbl_ADMIN_main] ([id_Admin], [ad_typeID], [ad_username], [ad_password], [ad_firstname], [ad_lastname], [ad_avatarprofile], [ad_email], [ad_phone], [ad_mobile], [ad_has2stepSecurity], [ad_isActive], [ad_isDelete], [ad_lastseen], [ad_lastlogin], [ad_loginIP], [ad_regdate], [ad_personalColorHexa], [AdminModeID], [ad_NickName]) VALUES (15, 5, N'mohammad', N'1', N'mohammad', N'bagheri', N'https://image.flaticon.com/icons/svg/1998/1998657.svg', N'1', N'1', N'1', 1, 0, 0, NULL, NULL, NULL, CAST(N'2020-03-10T16:22:46.983' AS DateTime), N'#b50404', NULL, N'1')
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_main] OFF
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ON 

INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (1, N'تمامی دسته بندی ها')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (2, N'سر دسته ی محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (3, N'گروه اصلی محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (4, N'گروه محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (5, N'ویژگی های محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (6, N'جزئیات ویژگی ها')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (7, N'برچسب های اصلی')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (8, N'برچسب محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (9, N'صفحه ساز')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (10, N'محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (11, N'ادمین')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (1002, N'بلاگ')
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] OFF
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ON 

INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1, N'/Product/ShowCatTree', N'نمایش تمامی دسته بندی ها', 1)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2, N'/MS/Add_Type', N'نمایش صفحه ی سردسته ی محصولات', 2)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (3, N'/MS/TypePage', N'اضافه کردن و ویرایش سر دسته ی محصولات', 2)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (4, N'/MS/table_Type', N'نمایش جدول سر دسته ی محصولات', 2)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (5, N'/MS/Type_Switch', N' ویرایش ،حذف ، فعال و غیر فعال کردن سر دسته ی محصولات', 2)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (6, N'/MS/maincat', N' نمایش صفحه ی گروه اصلی محصولات', 3)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (7, N'/MS/CatPage', N' اضافه کردن و ویرایش گروه اصلی محصولات', 3)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (8, N'/MS/table_Cat', N' نمایش جدول گروه اصلی محصولات', 3)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (9, N'/MS/Cat_Switch', N' ویرایش ،حذف ، فعال و غیر فعال کردن گروه اصلی محصولات', 3)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (10, N'/MS/SubCat', N' نمایش صفحه گروه محصولات', 4)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (11, N'/MS/SubPage', N' اضافه کردن و ویرایش گروه محصولات', 4)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (12, N'/MS/table_Sub', N' نمایش جدول گروه محصولات', 4)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (13, N'/MS/Sub_Switch', N' ویرایش ،حذف ، فعال و غیر فعال کردن گروه محصولات', 4)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (14, N'/MS/SubCatKey', N' نمایش صفحه ویژگی محصولات', 5)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (15, N'/MS/SCKPage', N' اضافه کردن و ویرایش ویژگی محصولات', 5)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (16, N'/MS/table_SCK', N' نمایش جدول ویژگی محصولات', 5)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (17, N'/MS/SCK_Switch', N' ویرایش ،حذف ، فعال و غیر فعال کردن ویژگی محصولات', 5)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (18, N'/MS/New_SCV', N' نمایش صفحه جزئیات ویژگی ها', 6)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (19, N'/MS/SCV_Add_Update', N'اضافه کردن ، ویرایش و حذف جزئیات ویژگی ها', 6)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (20, N'/MS/SCV_table', N'نمایش جدول جزئیات ویژگی ها', 6)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (21, N'/Product/Product_List', N'نمایش جدول محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (22, N'/Product/Add_Product', N'اضافه کردن محصول', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (23, N'/Product/Options_Table', N'نمایش جدول ویژگی های مشترک محصول', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (24, N'/Product/Op_delete_edit', N'اضافه کردن ، ویرایش و حذف ویژگی های مشترک محصول', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (25, N'/Product/UploadPage', N'آپلود عکس محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (26, N'/Product/Update_Product', N'ویرایش محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (28, N'/Product/ProductDetails', N'نمایش و ویرایش قیمت جزئیات محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (29, N'/Product/Product_Actions', N'حذف ، فعال و غیر فعال کردن محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (30, N'/Product/AddTag', N' نمایش صفحه برچسب محصولات', 8)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (31, N'/Product/Add_MainTag', N' نمایش صفحه برچسب های اصلی', 7)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (32, N'/Product/MainTag_Add_Update', N' اضافه کردن ، ویرایش و حذف برچسب های اصلی', 7)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (33, N'/Product/Tag_Add_Update', N' اضافه کردن ، ویرایش و حذف برچسب محصولات', 8)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (34, N'/Product/TagsTable', N' نمایش جدول برچسب محصولات', 8)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (35, N'/Product/MainTag_table', N' نمایش جدول برچسب های اصلی', 7)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1002, N'BlogMain/NewBlogPost', N'اضافه کردن و ویرایش پست ها', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1003, N'BlogMain/Add_Blog_Category', N'اضافه کردن و ویرایش دسته بندی پست ها', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1004, N'BlogMain/Add_Blog_Group', N'اضافه کردن و ویرایش گروه پست ها', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1005, N'BlogMain/Add_Blog_Tags', N'اضافه کردن و ویرایش برچسب پست ها', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1006, N'BlogMain/Blog_catTable', N'نمایش جدول دسته بندی پست ها', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1007, N'BlogMain/Blog_GroupTable', N'نمایش جدول گروه پست ها', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1008, N'BlogMain/Blog_TagTable', N'نمایش جدول برچسب پست ها', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1009, N'BlogMain/BlogCat_Actions', N'حذف ، فعال و غیرفعال کردن دسته بندی پست ها', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1010, N'BlogMain/BlogGroup_Actions', N'حذف ، فعال و غیرفعال کردن گروه پست ها', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1011, N'BlogMain/BlogTag_Actions', N'حذف ، فعال و غیرفعال کردن برچسب پست ها', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1012, N'BlogMain/PostTable', N'نمایش جدول پست ها', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1013, N'BlogMain/Post_Actions', N'حذف ، فعال و غیرفعال کردن پست ها', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1014, N'Admin/AddAdminType', N'اضافه کردن و ویرایش نوع ادمین', 11)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1015, N'Admin/AdminTbl', N'نمایش جدول نوع ادمین', 11)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1016, N'Admin/ModalTree', N'نمایش دسترسی نوع ادمین ها', 11)
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] OFF
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_types] ON 

INSERT [dbo].[tbl_ADMIN_types] ([ad_typeID], [ad_type_name]) VALUES (1, N'ادمین اصلی')
INSERT [dbo].[tbl_ADMIN_types] ([ad_typeID], [ad_type_name]) VALUES (2, N'type 2')
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_types] OFF
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 1, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 3, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 4, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 5, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 6, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 7, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 8, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 9, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 10, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 11, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 12, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 13, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 14, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 15, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 16, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 17, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 18, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 19, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 20, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 31, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 32, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 35, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 30, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 33, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 34, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 21, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 22, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 23, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 24, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 25, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 26, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 28, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 29, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 1, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 2, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 3, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 4, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 5, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 6, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 7, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 8, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 9, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 10, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 11, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 12, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 13, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 14, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 15, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 16, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 17, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 18, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 19, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 20, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 31, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 32, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 35, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 30, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 33, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 34, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 21, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 22, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 23, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 24, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 25, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 26, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 28, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (0, 29, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 1002, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 1003, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 1004, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 1005, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 1006, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 1007, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 1008, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 1009, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 1010, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 1011, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 1012, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 1013, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 1, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 2, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 3, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 4, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 5, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 6, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 7, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 8, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 9, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 10, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 11, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 12, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 13, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 14, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 15, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 16, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 17, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 18, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 19, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 20, 1)
GO
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 31, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 32, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 35, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 30, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 33, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 34, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 21, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 22, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 23, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 24, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 25, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 26, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 28, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (2, 29, 1)
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_UploaderStructure] ON 

INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (1, 1, 0, N'3', N'dasd', N' 1')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (2, 1, 0, N'3', N'dasd', N'2')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (3, 1, 0, N'3', N'2734074d-ce6a-4b37-b5c4-ac0595a310365e1c20920fd5e.png.png', N'2')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (4, 1, 0, N'3', N'e6a243ac-cbe2-49e1-a810-5b6dd212b05c5e1c20920fd5e.png', N'3')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (5, 1, 0, N'3', N'1dcf96b4-6626-4f24-83fe-e0454afd880ccertificate.png', N'3')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (6, 1, 0, N'3', N'93cd7231-cc5d-4bba-861a-12e4e051edb1honeycomb-transparent-background-12.png', N'4')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (7, 1, 0, N'3', N'53aece35-056d-4df9-acf6-c6da90e2a091bear.png', N'5')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (8, 1, 0, N'3', N'874a943e-3f4a-45f5-87fc-45e1f35b6f21frame.png', N'5')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (9, 1, 0, N'3', N'a6281c03-15dd-417a-bff2-287493ed0c845e1c20920fd5e.png', N'5')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (10, 1, 0, N'4', N'3', N'55')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (11, 1, 0, N'3', N'ab3b121d-7152-4124-8934-912723a7dc7eframe.png', N'5')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (12, 1, 0, N'فضااا', N'فضا', N'سیانابنتل')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (13, 1, 0, N'sdfsf', N'u;s', N'afsfs')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (1012, 1, 0, N'تسلمن', N'1', N'سال»آ»ۀ')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (2012, 1, 0, N'111', N'1', N'1111')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (2013, 1, 0, N'1', N'11', N'123')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (3012, 1, 0, N'123', N'123', N'123')
INSERT [dbo].[tbl_ADMIN_UploaderStructure] ([PicID], [PicCategoryType], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (4012, 1, 0, N'پاندا', N'پاندا', N'پاندا')
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_UploaderStructure] OFF
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_UploaderStructure_CategoryPic] ON 

INSERT [dbo].[tbl_ADMIN_UploaderStructure_CategoryPic] ([PicCategoryType], [PicCategoryTypeName]) VALUES (1, N'Product')
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_UploaderStructure_CategoryPic] OFF
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_UploaderStructure_ImageSize] ON 

INSERT [dbo].[tbl_ADMIN_UploaderStructure_ImageSize] ([picSizeType], [picSizeTypeName], [picSizeTypeWidth], [picSizeTypeHeight]) VALUES (1, N'normal', 400, 400)
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_UploaderStructure_ImageSize] OFF
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (3, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند2734074d-ce6a-4b37-b5c4-ac0595a310365e1c20920fd5e.png.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند2734074d-ce6a-4b37-b5c4-ac0595a310365e1c20920fd5e.png.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (4, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\e6a243ac-cbe2-49e1-a810-5b6dd212b05c5e1c20920fd5e.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\e6a243ac-cbe2-49e1-a810-5b6dd212b05c5e1c20920fd5e.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (5, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\1dcf96b4-6626-4f24-83fe-e0454afd880ccertificate.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\1dcf96b4-6626-4f24-83fe-e0454afd880ccertificate.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (6, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\93cd7231-cc5d-4bba-861a-12e4e051edb1honeycomb-transparent-background-12.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\93cd7231-cc5d-4bba-861a-12e4e051edb1honeycomb-transparent-background-12.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (7, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\53aece35-056d-4df9-acf6-c6da90e2a091bear.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\53aece35-056d-4df9-acf6-c6da90e2a091bear.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (8, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\874a943e-3f4a-45f5-87fc-45e1f35b6f21frame.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\874a943e-3f4a-45f5-87fc-45e1f35b6f21frame.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (9, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\a6281c03-15dd-417a-bff2-287493ed0c845e1c20920fd5e.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\a6281c03-15dd-417a-bff2-287493ed0c845e1c20920fd5e.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (10, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\4384791f-0409-4f86-ad5b-8e4d0de436fdkisspng-entity-framework-core-asp-net-core-net-framework-asp-5b40cad7ad6b40.1491365815309728877103.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\4384791f-0409-4f86-ad5b-8e4d0de436fdkisspng-entity-framework-core-asp-net-core-net-framework-asp-5b40cad7ad6b40.1491365815309728877103.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (11, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\ab3b121d-7152-4124-8934-912723a7dc7eframe.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\ab3b121d-7152-4124-8934-912723a7dc7eframe.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (3, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند2734074d-ce6a-4b37-b5c4-ac0595a310365e1c20920fd5e.png.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند2734074d-ce6a-4b37-b5c4-ac0595a310365e1c20920fd5e.png.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (4, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\e6a243ac-cbe2-49e1-a810-5b6dd212b05c5e1c20920fd5e.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\e6a243ac-cbe2-49e1-a810-5b6dd212b05c5e1c20920fd5e.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (5, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\1dcf96b4-6626-4f24-83fe-e0454afd880ccertificate.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\1dcf96b4-6626-4f24-83fe-e0454afd880ccertificate.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (6, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\93cd7231-cc5d-4bba-861a-12e4e051edb1honeycomb-transparent-background-12.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\93cd7231-cc5d-4bba-861a-12e4e051edb1honeycomb-transparent-background-12.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (12, 1, N'/images/Uploaded/1398/اسفند/cb91a819-8f68-4b3e-aeda-2b07f748747c7038712-spectrum-planet.jpg', N'/images/Uploaded/1398/اسفند/cb91a819-8f68-4b3e-aeda-2b07f748747c7038712-spectrum-planet.jpg')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (1012, 1, N'/images/Uploaded/1398/اسفند/e9e77d88-3fdb-4ef4-a3a9-67e8d68871f27038712-spectrum-planet.jpg', N'/images/Uploaded/1398/اسفند/e9e77d88-3fdb-4ef4-a3a9-67e8d68871f27038712-spectrum-planet.jpg')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (7, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\53aece35-056d-4df9-acf6-c6da90e2a091bear.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\53aece35-056d-4df9-acf6-c6da90e2a091bear.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (8, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\874a943e-3f4a-45f5-87fc-45e1f35b6f21frame.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\874a943e-3f4a-45f5-87fc-45e1f35b6f21frame.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (9, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\a6281c03-15dd-417a-bff2-287493ed0c845e1c20920fd5e.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\a6281c03-15dd-417a-bff2-287493ed0c845e1c20920fd5e.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (10, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\4384791f-0409-4f86-ad5b-8e4d0de436fdkisspng-entity-framework-core-asp-net-core-net-framework-asp-5b40cad7ad6b40.1491365815309728877103.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\4384791f-0409-4f86-ad5b-8e4d0de436fdkisspng-entity-framework-core-asp-net-core-net-framework-asp-5b40cad7ad6b40.1491365815309728877103.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (11, 1, N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\ab3b121d-7152-4124-8934-912723a7dc7eframe.png', N'E:\projects\PCMSP-master\ShoppingCMS_V002\images\Uploaded\1398\اسفند\ab3b121d-7152-4124-8934-912723a7dc7eframe.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (2012, 1, N'/images/Uploaded/1398/اسفند/cd266a6a-e1a4-4a68-8b3d-b9f40bea52b87038712-spectrum-planet.jpg', N'/images/Uploaded/1398/اسفند/cd266a6a-e1a4-4a68-8b3d-b9f40bea52b87038712-spectrum-planet.jpg')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (2013, 1, N'/images/Uploaded/1398/اسفند/5e71a13b-f299-434c-92fe-028e41a047bf7026128-purple-lines.jpg', N'/images/Uploaded/1398/اسفند/5e71a13b-f299-434c-92fe-028e41a047bf7026128-purple-lines.jpg')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (3012, 1, N'/images/Uploaded/1399/فروردین/910bc6b6-038b-48da-be28-62160d25c6ea7026128-purple-lines.jpg', N'/images/Uploaded/1399/فروردین/910bc6b6-038b-48da-be28-62160d25c6ea7026128-purple-lines.jpg')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (4012, 1, N'/images/Uploaded/1399/فروردین/cf756cc8-5092-455e-b357-191462ea1715panda-bear.png', N'/images/Uploaded/1399/فروردین/cf756cc8-5092-455e-b357-191462ea1715panda-bear.png')
INSERT [dbo].[tbl_ADMIN_UploadStructure_ImageAddress] ([PicID], [PicSizeType], [PicAddress], [PicThumbnailAddress]) VALUES (13, 1, N'/images/Uploaded/1398/اسفند/1a0c3116-8bb9-427c-8486-050d456169c47038712-spectrum-planet.jpg', N'/images/Uploaded/1398/اسفند/1a0c3116-8bb9-427c-8486-050d456169c47038712-spectrum-planet.jpg')
SET IDENTITY_INSERT [dbo].[tbl_BLOG_Categories] ON 

INSERT [dbo].[tbl_BLOG_Categories] ([Id], [name], [Is_Disabled], [Is_Deleted]) VALUES (1, N'اخبار پاندایی', 0, 0)
INSERT [dbo].[tbl_BLOG_Categories] ([Id], [name], [Is_Disabled], [Is_Deleted]) VALUES (2, N'تکنولوژی', 0, 1)
INSERT [dbo].[tbl_BLOG_Categories] ([Id], [name], [Is_Disabled], [Is_Deleted]) VALUES (3, N'جهان', 0, 0)
SET IDENTITY_INSERT [dbo].[tbl_BLOG_Categories] OFF
SET IDENTITY_INSERT [dbo].[tbl_BLOG_Groups] ON 

INSERT [dbo].[tbl_BLOG_Groups] ([G_Id], [name], [Is_Disabled], [Is_Deleted]) VALUES (1, N'اخبار', 0, 0)
INSERT [dbo].[tbl_BLOG_Groups] ([G_Id], [name], [Is_Disabled], [Is_Deleted]) VALUES (2, N'فروش های ویژه', 0, 1)
SET IDENTITY_INSERT [dbo].[tbl_BLOG_Groups] OFF
INSERT [dbo].[tbl_BLOG_Pic_Connector] ([PostId], [PicId]) VALUES (1, 4012)
INSERT [dbo].[tbl_BLOG_Pic_Connector] ([PostId], [PicId]) VALUES (2, 4012)
SET IDENTITY_INSERT [dbo].[tbl_BLOG_Post] ON 

INSERT [dbo].[tbl_BLOG_Post] ([Id], [Title], [Text_min], [Text], [WrittenBy_AdminId], [Date], [weight], [IsImportant], [Is_Deleted], [Is_Disabled], [Cat_Id], [GroupId]) VALUES (1, N'پاندا', N'تاسیس پاندا', N'<p>پاندایی ها آمدند<img alt="laugh" height="23" src="https://localhost:44336/assets/js/pages/custom/Plugins/ckeditor/plugins/smiley/images/teeth_smile.png" title="laugh" width="23" /><img alt="heart" height="23" src="https://localhost:44336/assets/js/pages/custom/Plugins/ckeditor/plugins/smiley/images/heart.png" title="heart" width="23" /></p>
', 2, CAST(N'2020-04-05T20:03:07.597' AS DateTime), 100, 1, 0, 0, 1, 1)
INSERT [dbo].[tbl_BLOG_Post] ([Id], [Title], [Text_min], [Text], [WrittenBy_AdminId], [Date], [weight], [IsImportant], [Is_Deleted], [Is_Disabled], [Cat_Id], [GroupId]) VALUES (2, N'پاندا', N'تاسیس پاندا', N'<p>پاندایی ها آمدند<img alt="laugh" height="23" src="https://localhost:44336/assets/js/pages/custom/Plugins/ckeditor/plugins/smiley/images/teeth_smile.png" title="laugh" width="23" /><img alt="heart" height="23" src="https://localhost:44336/assets/js/pages/custom/Plugins/ckeditor/plugins/smiley/images/heart.png" title="heart" width="23" /></p>
', 2, CAST(N'2020-04-05T20:07:52.857' AS DateTime), 100, 1, 0, 0, 1, 1)
SET IDENTITY_INSERT [dbo].[tbl_BLOG_Post] OFF
INSERT [dbo].[tbl_BLOG_TagConnector] ([Post_Id], [Tag_Id]) VALUES (2, 1)
INSERT [dbo].[tbl_BLOG_TagConnector] ([Post_Id], [Tag_Id]) VALUES (2, 2)
SET IDENTITY_INSERT [dbo].[tbl_BLOG_Tags] ON 

INSERT [dbo].[tbl_BLOG_Tags] ([Id], [Name], [CtegoryId], [Is_Disabled], [Is_Deleted]) VALUES (1, N'پاندا', 1, 0, 0)
INSERT [dbo].[tbl_BLOG_Tags] ([Id], [Name], [CtegoryId], [Is_Disabled], [Is_Deleted]) VALUES (2, N'خبر', 1, 0, 1)
INSERT [dbo].[tbl_BLOG_Tags] ([Id], [Name], [CtegoryId], [Is_Disabled], [Is_Deleted]) VALUES (3, N'توسعه سیستم پاندا', 1, 0, 0)
INSERT [dbo].[tbl_BLOG_Tags] ([Id], [Name], [CtegoryId], [Is_Disabled], [Is_Deleted]) VALUES (4, N'ایران', 3, 0, 0)
SET IDENTITY_INSERT [dbo].[tbl_BLOG_Tags] OFF
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (100, N'بوشهر', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (101, N'اهرم', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (102, N'برازجان', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (103, N'تنگستان', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (104, N'خارک', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (105, N'خورموج', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (106, N'دشتستان', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (107, N'دشتی', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (108, N'دیر', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (109, N'دیلم', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (110, N'ریشهر', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (111, N'کنگان', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (112, N'گناوه', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (113, N'تهران', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (114, N'آسارا', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (115, N'اسلامشهر', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (116, N'اشتهارد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (117, N'بومهن', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (118, N'تجریش', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (119, N'دماوند', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (120, N'رباط کریم', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (121, N'رودهن', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (122, N'ری', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (123, N'شریف آباد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (124, N'شهریار', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (125, N'طالقان', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (126, N'فشم', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (127, N'فیروزکوه', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (128, N'قدس', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (129, N'قرچک', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (130, N'لواسان', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (131, N'ملارد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (132, N'نظرآباد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (133, N'هشتگرد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (134, N'ورامین', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (135, N'پاکدشت', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (136, N'چهاردانگه', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (137, N'کن', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (138, N'کهریزک', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (139, N'گلستان', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (140, N'خراسان جنوبی', 9, N'خراسان جنوبی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (141, N'بیرجند', 9, N'خراسان جنوبی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (142, N'سرپیشه', 9, N'خراسان جنوبی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (143, N'نهبندان', 9, N'خراسان جنوبی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (144, N'خراسان رضوی', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (145, N'بردسکن', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (146, N'تایباد', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (147, N'تربت جام', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (148, N'تربت حیدریه', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (149, N'خواف', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (150, N'درگز', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (151, N'سبزوار', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (152, N'سرخس', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (153, N'طرقبه', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (154, N'فردوس', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (155, N'فریمان', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (156, N'قائن', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (157, N'قوچان', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (158, N'مشهد', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (159, N'نیشابور', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (160, N'چناران', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (161, N'کاشمهر', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (162, N'کلات', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (163, N'گناباد', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (164, N'خراسان شمالی', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (165, N'آشخانه', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (166, N'اسفراین', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (167, N'بجنورد', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (168, N'جاجرم', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (169, N'شیروان', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (170, N'خوزستان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (171, N'آبادان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (172, N'امیدیه', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (173, N'اندیمشک', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (174, N'اهواز', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (175, N'ایذه', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (176, N'ایرانشهر', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (177, N'باغ ملک', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (178, N'بندر ماهشهر', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (179, N'بندرامام خمینی', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (180, N'بهبهان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (181, N'خرمشهر', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (182, N'دزفول', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (183, N'رامهرمز', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (184, N'سوسنگرد', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (185, N'شادگان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (186, N'شوش', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (187, N'شوشتر', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (188, N'لالی', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (189, N'مسجدسلیمان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (190, N'هندیجان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (191, N'هویزه', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (192, N'زنجان', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (193, N'اب بر', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (194, N'ابهر', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (195, N'ایجرود', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (196, N'خدابنده', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (197, N'خرمدره', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (198, N'زرین آباد', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (199, N'قیدار', 13, N'زنجان')
GO
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (200, N'ماهنشان', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (201, N'کارم', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (202, N'سمنان', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (203, N'ایوانکی', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (204, N'بسطام', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (205, N'دامغان', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (206, N'شاهرود', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (207, N'گرمسار', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (208, N'سیستان و بلوچستان', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (209, N'ایرانشهر', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (210, N'خاش', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (211, N'راسک', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (212, N'زابل', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (213, N'زاهدان', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (214, N'سراوان', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (215, N'سرباز', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (216, N'میرجاوه', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (217, N'نیکشهر', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (218, N'چابهار', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (219, N'فارس', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (220, N'آباده', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (221, N'اردکان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (222, N'ارسنجان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (223, N'استهبان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (224, N'اقلید', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (225, N'جهرم', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (226, N'حاجی آباد', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (227, N'خرم بید', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (228, N'داراب', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (229, N'سوریان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (230, N'سپیدان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (231, N'شیراز', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (232, N'صفا شهر', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (233, N'فراشبند', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (234, N'فسا', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (235, N'فیروزآباد', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (236, N'قیروکارزین', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (237, N'لار', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (238, N'لامرد', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (239, N'مرودشت', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (240, N'ممسنی', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (241, N'مهر', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (242, N'نورآباد', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (243, N'نی ریز', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (244, N'کازرون', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (245, N'قزوین', 17, N'قزوین')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (246, N'آبیک', 17, N'قزوین')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (247, N'بوئین زهرا', 17, N'قزوین')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (248, N'تاکستان', 17, N'قزوین')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (249, N'قم', 18, N'قم')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (250, N'لرستان', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (251, N'ازنا', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (252, N'الشتر', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (253, N'الیگودرز', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (254, N'بروجرد', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (255, N'خرم آباد', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (256, N'دزفول', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (257, N'دورود', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (258, N'ماهشهر', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (259, N'نورآباد', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (260, N'پلدختر', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (261, N'کوهدشت', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (262, N'مازندران', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (263, N'آمل', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (264, N'بابل', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (265, N'بابلسر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (266, N'بلده', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (267, N'بهشهر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (268, N'تنکابن', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (269, N'جویبار', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (270, N'رامسر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (271, N'ساری', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (272, N'سواد کوه', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (273, N'فریدون کنار', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (274, N'قائم شهر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (275, N'محمود آباد', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (276, N'نور', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (277, N'نوشهر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (278, N'نکا', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (279, N'پل سفید', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (280, N'چالوس', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (281, N'مرکزی', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (282, N'آشتیان', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (283, N'اراک', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (284, N'تفرش', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (285, N'خمین', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (286, N'دلیجان', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (287, N'ساوه', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (288, N'سربند', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (289, N'شازند', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (290, N'محلات', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (291, N'هرمزگان', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (292, N'ابوموسی', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (293, N'انگهران', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (294, N'بستک', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (295, N'بندر جاسک', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (296, N'بندر عباس', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (297, N'بندرلنگه', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (298, N'تنب بزرگ', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (299, N'حاجی آباد', 22, N'هرمزگان')
GO
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (300, N'دهبا رز', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (301, N'قشم', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (302, N'میناب', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (303, N'کیش', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (304, N'همدان', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (305, N'اسدآباد', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (306, N'بهار', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (307, N'تویسرکان', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (308, N'رزن', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (309, N'ملایر', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (310, N'نهاوند', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (311, N'کبودراهنگ', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (312, N'چهارمحال و بختیاری', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (313, N'اردل', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (314, N'بروجن', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (315, N'سامان', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (316, N'شهرکرد', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (317, N'فارسان', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (318, N'لردگان', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (319, N'چلگرد', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (320, N'کردستان', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (321, N'بانه', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (322, N'بیجار', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (323, N'دیواندره', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (324, N'سقز', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (325, N'سنندج', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (326, N'قروه', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (327, N'مریوان', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (328, N'کامیاران', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (329, N'کرمان', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (330, N'بابک', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (331, N'بافت', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (332, N'بردسیر', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (333, N'بم', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (334, N'جیرفت', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (335, N'راور', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (336, N'رفسنجان', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (337, N'زرند', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (338, N'سیرجان', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (339, N'قصرشیرین', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (340, N'کهنوج', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (341, N'کرمانشاه', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (342, N'اسلام آبا د غرب', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (343, N'جوانرود', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (344, N'سرپل ذهاب', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (345, N'سنقر', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (346, N'صحنه', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (347, N'هرسین', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (348, N'پاوه', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (349, N'کنگاور', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (350, N'گیلان غرب', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (351, N'کهکلویه و بویراحمد', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (352, N'دنا', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (353, N'دهدشت', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (354, N'دوگنبدان', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (355, N'سی سخت', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (356, N'گچساران', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (357, N'یاسوج', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (358, N'گلستان', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (359, N'آزادشهر', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (360, N'آق قلا', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (361, N'بندر گز', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (362, N'ترکمن', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (363, N'رامیان', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (364, N'علی آباد کتول', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (365, N'مینودشت', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (366, N'کردکوی', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (367, N'کلاله', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (368, N'گرگان', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (369, N'گنبد کاووس', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (370, N'گیلان', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (371, N'آستارا', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (372, N'آستانه اشرفیه', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (373, N'املش', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (374, N'بندر انزلی', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (375, N'تالش', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (376, N'خشکبیجار', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (377, N'خمام', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (378, N'رحیم آباد', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (379, N'رشت', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (380, N'رضوان شهر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (381, N'رودبار', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (382, N'رودسر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (383, N'سنگر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (384, N'سیاهکل', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (385, N'شفت', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (386, N'صومعه سرا', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (387, N'فومن', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (388, N'لاهیجان', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (389, N'لشت نشا', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (390, N'لنگرود', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (391, N'ماسال', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (392, N'ماسوله', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (393, N'منجیل', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (394, N'هشتپر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (395, N'چابکسر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (396, N'کلاچای', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (397, N'کوچصفهان', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (398, N'کیاشهر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (399, N'یزد', 31, N'یزد')
GO
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (400, N'ابرکوه', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (401, N'اردکان', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (402, N'اشکذر', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (403, N'بافق', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (404, N'تفت', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (405, N'طبس', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (406, N'مهریز', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (407, N'میبد', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (408, N'هرات', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (409, N'*نامشخص*', 32, N'*نامشخص*')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (100, N'بوشهر', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (101, N'اهرم', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (102, N'برازجان', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (103, N'تنگستان', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (104, N'خارک', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (105, N'خورموج', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (106, N'دشتستان', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (107, N'دشتی', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (108, N'دیر', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (109, N'دیلم', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (110, N'ریشهر', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (111, N'کنگان', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (112, N'گناوه', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (113, N'تهران', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (114, N'آسارا', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (115, N'اسلامشهر', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (116, N'اشتهارد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (117, N'بومهن', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (118, N'تجریش', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (119, N'دماوند', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (120, N'رباط کریم', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (121, N'رودهن', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (122, N'ری', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (123, N'شریف آباد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (124, N'شهریار', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (125, N'طالقان', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (126, N'فشم', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (127, N'فیروزکوه', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (128, N'قدس', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (129, N'قرچک', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (130, N'لواسان', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (131, N'ملارد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (132, N'نظرآباد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (133, N'هشتگرد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (134, N'ورامین', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (135, N'پاکدشت', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (136, N'چهاردانگه', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (137, N'کن', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (138, N'کهریزک', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (139, N'گلستان', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (140, N'خراسان جنوبی', 9, N'خراسان جنوبی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (141, N'بیرجند', 9, N'خراسان جنوبی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (142, N'سرپیشه', 9, N'خراسان جنوبی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (143, N'نهبندان', 9, N'خراسان جنوبی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (144, N'خراسان رضوی', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (145, N'بردسکن', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (146, N'تایباد', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (147, N'تربت جام', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (148, N'تربت حیدریه', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (149, N'خواف', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (150, N'درگز', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (151, N'سبزوار', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (152, N'سرخس', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (153, N'طرقبه', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (154, N'فردوس', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (155, N'فریمان', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (156, N'قائن', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (157, N'قوچان', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (158, N'مشهد', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (159, N'نیشابور', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (160, N'چناران', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (161, N'کاشمهر', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (162, N'کلات', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (163, N'گناباد', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (164, N'خراسان شمالی', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (165, N'آشخانه', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (166, N'اسفراین', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (167, N'بجنورد', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (168, N'جاجرم', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (169, N'شیروان', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (170, N'خوزستان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (171, N'آبادان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (172, N'امیدیه', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (173, N'اندیمشک', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (174, N'اهواز', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (175, N'ایذه', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (176, N'ایرانشهر', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (177, N'باغ ملک', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (178, N'بندر ماهشهر', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (179, N'بندرامام خمینی', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (180, N'بهبهان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (181, N'خرمشهر', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (182, N'دزفول', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (183, N'رامهرمز', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (184, N'سوسنگرد', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (185, N'شادگان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (186, N'شوش', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (187, N'شوشتر', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (188, N'لالی', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (189, N'مسجدسلیمان', 12, N'خوزستان')
GO
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (190, N'هندیجان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (191, N'هویزه', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (192, N'زنجان', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (193, N'اب بر', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (194, N'ابهر', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (195, N'ایجرود', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (196, N'خدابنده', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (197, N'خرمدره', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (198, N'زرین آباد', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (199, N'قیدار', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (200, N'ماهنشان', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (201, N'کارم', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (202, N'سمنان', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (203, N'ایوانکی', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (204, N'بسطام', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (205, N'دامغان', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (206, N'شاهرود', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (207, N'گرمسار', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (208, N'سیستان و بلوچستان', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (209, N'ایرانشهر', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (210, N'خاش', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (211, N'راسک', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (212, N'زابل', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (213, N'زاهدان', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (214, N'سراوان', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (215, N'سرباز', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (216, N'میرجاوه', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (217, N'نیکشهر', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (218, N'چابهار', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (219, N'فارس', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (220, N'آباده', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (221, N'اردکان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (222, N'ارسنجان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (223, N'استهبان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (224, N'اقلید', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (225, N'جهرم', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (226, N'حاجی آباد', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (227, N'خرم بید', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (228, N'داراب', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (229, N'سوریان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (230, N'سپیدان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (231, N'شیراز', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (232, N'صفا شهر', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (233, N'فراشبند', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (234, N'فسا', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (235, N'فیروزآباد', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (236, N'قیروکارزین', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (237, N'لار', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (238, N'لامرد', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (239, N'مرودشت', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (240, N'ممسنی', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (241, N'مهر', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (242, N'نورآباد', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (243, N'نی ریز', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (244, N'کازرون', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (245, N'قزوین', 17, N'قزوین')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (246, N'آبیک', 17, N'قزوین')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (247, N'بوئین زهرا', 17, N'قزوین')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (248, N'تاکستان', 17, N'قزوین')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (249, N'قم', 18, N'قم')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (250, N'لرستان', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (251, N'ازنا', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (252, N'الشتر', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (253, N'الیگودرز', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (254, N'بروجرد', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (255, N'خرم آباد', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (256, N'دزفول', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (257, N'دورود', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (258, N'ماهشهر', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (259, N'نورآباد', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (260, N'پلدختر', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (261, N'کوهدشت', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (262, N'مازندران', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (263, N'آمل', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (264, N'بابل', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (265, N'بابلسر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (266, N'بلده', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (267, N'بهشهر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (268, N'تنکابن', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (269, N'جویبار', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (270, N'رامسر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (271, N'ساری', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (272, N'سواد کوه', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (273, N'فریدون کنار', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (274, N'قائم شهر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (275, N'محمود آباد', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (276, N'نور', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (277, N'نوشهر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (278, N'نکا', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (279, N'پل سفید', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (280, N'چالوس', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (281, N'مرکزی', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (282, N'آشتیان', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (283, N'اراک', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (284, N'تفرش', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (285, N'خمین', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (286, N'دلیجان', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (287, N'ساوه', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (288, N'سربند', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (289, N'شازند', 21, N'مرکزی')
GO
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (290, N'محلات', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (291, N'هرمزگان', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (292, N'ابوموسی', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (293, N'انگهران', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (294, N'بستک', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (295, N'بندر جاسک', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (296, N'بندر عباس', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (297, N'بندرلنگه', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (298, N'تنب بزرگ', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (299, N'حاجی آباد', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (300, N'دهبا رز', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (301, N'قشم', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (302, N'میناب', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (303, N'کیش', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (304, N'همدان', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (305, N'اسدآباد', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (306, N'بهار', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (307, N'تویسرکان', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (308, N'رزن', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (309, N'ملایر', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (310, N'نهاوند', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (311, N'کبودراهنگ', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (312, N'چهارمحال و بختیاری', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (313, N'اردل', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (314, N'بروجن', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (315, N'سامان', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (316, N'شهرکرد', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (317, N'فارسان', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (318, N'لردگان', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (319, N'چلگرد', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (320, N'کردستان', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (321, N'بانه', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (322, N'بیجار', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (323, N'دیواندره', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (324, N'سقز', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (325, N'سنندج', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (326, N'قروه', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (327, N'مریوان', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (328, N'کامیاران', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (329, N'کرمان', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (330, N'بابک', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (331, N'بافت', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (332, N'بردسیر', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (333, N'بم', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (334, N'جیرفت', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (335, N'راور', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (336, N'رفسنجان', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (337, N'زرند', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (338, N'سیرجان', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (339, N'قصرشیرین', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (340, N'کهنوج', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (341, N'کرمانشاه', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (342, N'اسلام آبا د غرب', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (343, N'جوانرود', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (344, N'سرپل ذهاب', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (345, N'سنقر', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (346, N'صحنه', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (347, N'هرسین', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (348, N'پاوه', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (349, N'کنگاور', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (350, N'گیلان غرب', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (351, N'کهکلویه و بویراحمد', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (352, N'دنا', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (353, N'دهدشت', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (354, N'دوگنبدان', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (355, N'سی سخت', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (356, N'گچساران', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (357, N'یاسوج', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (358, N'گلستان', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (359, N'آزادشهر', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (360, N'آق قلا', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (361, N'بندر گز', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (362, N'ترکمن', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (363, N'رامیان', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (364, N'علی آباد کتول', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (365, N'مینودشت', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (366, N'کردکوی', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (367, N'کلاله', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (368, N'گرگان', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (369, N'گنبد کاووس', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (370, N'گیلان', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (371, N'آستارا', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (372, N'آستانه اشرفیه', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (373, N'املش', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (374, N'بندر انزلی', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (375, N'تالش', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (376, N'خشکبیجار', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (377, N'خمام', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (378, N'رحیم آباد', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (379, N'رشت', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (380, N'رضوان شهر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (381, N'رودبار', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (382, N'رودسر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (383, N'سنگر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (384, N'سیاهکل', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (385, N'شفت', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (386, N'صومعه سرا', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (387, N'فومن', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (388, N'لاهیجان', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (389, N'لشت نشا', 30, N'گیلان')
GO
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (390, N'لنگرود', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (391, N'ماسال', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (392, N'ماسوله', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (393, N'منجیل', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (394, N'هشتپر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (395, N'چابکسر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (396, N'کلاچای', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (397, N'کوچصفهان', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (398, N'کیاشهر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (399, N'یزد', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (400, N'ابرکوه', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (401, N'اردکان', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (402, N'اشکذر', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (403, N'بافق', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (404, N'تفت', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (405, N'طبس', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (406, N'مهریز', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (407, N'میبد', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (408, N'هرات', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (409, N'*نامشخص*', 32, N'*نامشخص*')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (100, N'بوشهر', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (101, N'اهرم', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (102, N'برازجان', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (103, N'تنگستان', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (104, N'خارک', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (105, N'خورموج', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (106, N'دشتستان', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (107, N'دشتی', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (108, N'دیر', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (109, N'دیلم', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (110, N'ریشهر', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (111, N'کنگان', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (112, N'گناوه', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (113, N'تهران', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (114, N'آسارا', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (115, N'اسلامشهر', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (116, N'اشتهارد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (117, N'بومهن', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (118, N'تجریش', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (119, N'دماوند', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (120, N'رباط کریم', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (121, N'رودهن', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (122, N'ری', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (123, N'شریف آباد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (124, N'شهریار', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (125, N'طالقان', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (126, N'فشم', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (127, N'فیروزکوه', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (128, N'قدس', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (129, N'قرچک', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (130, N'لواسان', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (131, N'ملارد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (132, N'نظرآباد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (133, N'هشتگرد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (134, N'ورامین', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (135, N'پاکدشت', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (136, N'چهاردانگه', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (137, N'کن', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (138, N'کهریزک', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (139, N'گلستان', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (140, N'خراسان جنوبی', 9, N'خراسان جنوبی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (141, N'بیرجند', 9, N'خراسان جنوبی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (142, N'سرپیشه', 9, N'خراسان جنوبی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (143, N'نهبندان', 9, N'خراسان جنوبی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (144, N'خراسان رضوی', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (145, N'بردسکن', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (146, N'تایباد', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (147, N'تربت جام', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (148, N'تربت حیدریه', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (149, N'خواف', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (150, N'درگز', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (151, N'سبزوار', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (152, N'سرخس', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (153, N'طرقبه', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (154, N'فردوس', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (155, N'فریمان', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (156, N'قائن', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (157, N'قوچان', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (158, N'مشهد', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (159, N'نیشابور', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (160, N'چناران', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (161, N'کاشمهر', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (162, N'کلات', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (163, N'گناباد', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (164, N'خراسان شمالی', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (165, N'آشخانه', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (166, N'اسفراین', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (167, N'بجنورد', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (168, N'جاجرم', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (169, N'شیروان', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (170, N'خوزستان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (171, N'آبادان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (172, N'امیدیه', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (173, N'اندیمشک', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (174, N'اهواز', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (175, N'ایذه', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (176, N'ایرانشهر', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (177, N'باغ ملک', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (178, N'بندر ماهشهر', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (179, N'بندرامام خمینی', 12, N'خوزستان')
GO
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (180, N'بهبهان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (181, N'خرمشهر', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (182, N'دزفول', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (183, N'رامهرمز', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (184, N'سوسنگرد', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (185, N'شادگان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (186, N'شوش', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (187, N'شوشتر', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (188, N'لالی', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (189, N'مسجدسلیمان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (190, N'هندیجان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (191, N'هویزه', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (192, N'زنجان', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (193, N'اب بر', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (194, N'ابهر', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (195, N'ایجرود', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (196, N'خدابنده', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (197, N'خرمدره', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (198, N'زرین آباد', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (199, N'قیدار', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (200, N'ماهنشان', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (201, N'کارم', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (202, N'سمنان', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (203, N'ایوانکی', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (204, N'بسطام', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (205, N'دامغان', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (206, N'شاهرود', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (207, N'گرمسار', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (208, N'سیستان و بلوچستان', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (209, N'ایرانشهر', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (210, N'خاش', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (211, N'راسک', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (212, N'زابل', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (213, N'زاهدان', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (214, N'سراوان', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (215, N'سرباز', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (216, N'میرجاوه', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (217, N'نیکشهر', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (218, N'چابهار', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (219, N'فارس', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (220, N'آباده', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (221, N'اردکان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (222, N'ارسنجان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (223, N'استهبان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (224, N'اقلید', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (225, N'جهرم', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (226, N'حاجی آباد', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (227, N'خرم بید', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (228, N'داراب', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (229, N'سوریان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (230, N'سپیدان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (231, N'شیراز', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (232, N'صفا شهر', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (233, N'فراشبند', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (234, N'فسا', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (235, N'فیروزآباد', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (236, N'قیروکارزین', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (237, N'لار', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (238, N'لامرد', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (239, N'مرودشت', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (240, N'ممسنی', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (241, N'مهر', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (242, N'نورآباد', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (243, N'نی ریز', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (244, N'کازرون', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (245, N'قزوین', 17, N'قزوین')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (246, N'آبیک', 17, N'قزوین')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (247, N'بوئین زهرا', 17, N'قزوین')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (248, N'تاکستان', 17, N'قزوین')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (249, N'قم', 18, N'قم')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (250, N'لرستان', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (251, N'ازنا', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (252, N'الشتر', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (253, N'الیگودرز', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (254, N'بروجرد', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (255, N'خرم آباد', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (256, N'دزفول', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (257, N'دورود', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (258, N'ماهشهر', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (259, N'نورآباد', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (260, N'پلدختر', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (261, N'کوهدشت', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (262, N'مازندران', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (263, N'آمل', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (264, N'بابل', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (265, N'بابلسر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (266, N'بلده', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (267, N'بهشهر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (268, N'تنکابن', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (269, N'جویبار', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (270, N'رامسر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (271, N'ساری', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (272, N'سواد کوه', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (273, N'فریدون کنار', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (274, N'قائم شهر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (275, N'محمود آباد', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (276, N'نور', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (277, N'نوشهر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (278, N'نکا', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (279, N'پل سفید', 20, N'مازندران')
GO
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (280, N'چالوس', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (281, N'مرکزی', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (282, N'آشتیان', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (283, N'اراک', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (284, N'تفرش', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (285, N'خمین', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (286, N'دلیجان', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (287, N'ساوه', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (288, N'سربند', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (289, N'شازند', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (290, N'محلات', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (291, N'هرمزگان', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (292, N'ابوموسی', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (293, N'انگهران', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (294, N'بستک', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (295, N'بندر جاسک', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (296, N'بندر عباس', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (297, N'بندرلنگه', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (298, N'تنب بزرگ', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (299, N'حاجی آباد', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (300, N'دهبا رز', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (301, N'قشم', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (302, N'میناب', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (303, N'کیش', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (304, N'همدان', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (305, N'اسدآباد', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (306, N'بهار', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (307, N'تویسرکان', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (308, N'رزن', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (309, N'ملایر', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (310, N'نهاوند', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (311, N'کبودراهنگ', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (312, N'چهارمحال و بختیاری', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (313, N'اردل', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (314, N'بروجن', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (315, N'سامان', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (316, N'شهرکرد', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (317, N'فارسان', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (318, N'لردگان', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (319, N'چلگرد', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (320, N'کردستان', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (321, N'بانه', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (322, N'بیجار', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (323, N'دیواندره', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (324, N'سقز', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (325, N'سنندج', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (326, N'قروه', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (327, N'مریوان', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (328, N'کامیاران', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (329, N'کرمان', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (330, N'بابک', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (331, N'بافت', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (332, N'بردسیر', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (333, N'بم', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (334, N'جیرفت', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (335, N'راور', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (336, N'رفسنجان', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (337, N'زرند', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (338, N'سیرجان', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (339, N'قصرشیرین', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (340, N'کهنوج', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (341, N'کرمانشاه', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (342, N'اسلام آبا د غرب', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (343, N'جوانرود', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (344, N'سرپل ذهاب', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (345, N'سنقر', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (346, N'صحنه', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (347, N'هرسین', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (348, N'پاوه', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (349, N'کنگاور', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (350, N'گیلان غرب', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (351, N'کهکلویه و بویراحمد', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (352, N'دنا', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (353, N'دهدشت', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (354, N'دوگنبدان', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (355, N'سی سخت', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (356, N'گچساران', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (357, N'یاسوج', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (358, N'گلستان', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (359, N'آزادشهر', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (360, N'آق قلا', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (361, N'بندر گز', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (362, N'ترکمن', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (363, N'رامیان', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (364, N'علی آباد کتول', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (365, N'مینودشت', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (366, N'کردکوی', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (367, N'کلاله', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (368, N'گرگان', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (369, N'گنبد کاووس', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (370, N'گیلان', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (371, N'آستارا', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (372, N'آستانه اشرفیه', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (373, N'املش', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (374, N'بندر انزلی', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (375, N'تالش', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (376, N'خشکبیجار', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (377, N'خمام', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (378, N'رحیم آباد', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (379, N'رشت', 30, N'گیلان')
GO
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (380, N'رضوان شهر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (381, N'رودبار', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (382, N'رودسر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (383, N'سنگر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (384, N'سیاهکل', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (385, N'شفت', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (386, N'صومعه سرا', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (387, N'فومن', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (388, N'لاهیجان', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (389, N'لشت نشا', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (390, N'لنگرود', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (391, N'ماسال', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (392, N'ماسوله', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (393, N'منجیل', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (394, N'هشتپر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (395, N'چابکسر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (396, N'کلاچای', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (397, N'کوچصفهان', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (398, N'کیاشهر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (399, N'یزد', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (400, N'ابرکوه', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (401, N'اردکان', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (402, N'اشکذر', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (403, N'بافق', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (404, N'تفت', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (405, N'طبس', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (406, N'مهریز', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (407, N'میبد', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (408, N'هرات', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (409, N'*نامشخص*', 32, N'*نامشخص*')
SET IDENTITY_INSERT [dbo].[tbl_Product] ON 

INSERT [dbo].[tbl_Product] ([id_MProduct], [IS_AVAILABEL], [id_CreatedByAdmin], [id_DraftLevel], [id_Type], [id_MainCategory], [id_SubCategory], [idMPC_WhichTomainPrice], [Description], [DateCreated], [Title], [Seo_Description], [Seo_KeyWords], [IS_AD], [Search_Gravity], [Is_IntheDraft], [ISDELETE]) VALUES (4, 1, 1, NULL, 1, 1, 1, 1, N'خووبه', CAST(N'2020-02-20T12:01:11.300' AS DateTime), N'galaxy s8', N'galaxy s8', N'galaxy', 1, 100, 1, 0)
INSERT [dbo].[tbl_Product] ([id_MProduct], [IS_AVAILABEL], [id_CreatedByAdmin], [id_DraftLevel], [id_Type], [id_MainCategory], [id_SubCategory], [idMPC_WhichTomainPrice], [Description], [DateCreated], [Title], [Seo_Description], [Seo_KeyWords], [IS_AD], [Search_Gravity], [Is_IntheDraft], [ISDELETE]) VALUES (5, 0, 1, 0, 0, 0, 0, 0, N'ddddddddddd', CAST(N'2020-03-08T23:46:37.440' AS DateTime), N'ddddddddd', N'ddddddddddddddddddddddddddddddddd', N'dddddddddddddddddd', 1, 100, 0, 0)
INSERT [dbo].[tbl_Product] ([id_MProduct], [IS_AVAILABEL], [id_CreatedByAdmin], [id_DraftLevel], [id_Type], [id_MainCategory], [id_SubCategory], [idMPC_WhichTomainPrice], [Description], [DateCreated], [Title], [Seo_Description], [Seo_KeyWords], [IS_AD], [Search_Gravity], [Is_IntheDraft], [ISDELETE]) VALUES (6, 0, 1, 0, 0, 0, 0, 0, N'ddddddddddd', CAST(N'2020-03-08T23:50:25.200' AS DateTime), N'ddddddddd', N'ddddddddddddddddddddddddddddddddd', N'dddddddddddddddddd', 1, 100, 0, 0)
INSERT [dbo].[tbl_Product] ([id_MProduct], [IS_AVAILABEL], [id_CreatedByAdmin], [id_DraftLevel], [id_Type], [id_MainCategory], [id_SubCategory], [idMPC_WhichTomainPrice], [Description], [DateCreated], [Title], [Seo_Description], [Seo_KeyWords], [IS_AD], [Search_Gravity], [Is_IntheDraft], [ISDELETE]) VALUES (7, 0, 1, 0, 0, 0, 0, 0, N'sssssss', CAST(N'2020-03-09T00:08:00.340' AS DateTime), N'sssss', N'sssssss', N'ssssss', 1, 22, 0, 0)
INSERT [dbo].[tbl_Product] ([id_MProduct], [IS_AVAILABEL], [id_CreatedByAdmin], [id_DraftLevel], [id_Type], [id_MainCategory], [id_SubCategory], [idMPC_WhichTomainPrice], [Description], [DateCreated], [Title], [Seo_Description], [Seo_KeyWords], [IS_AD], [Search_Gravity], [Is_IntheDraft], [ISDELETE]) VALUES (3007, 1, 1, 0, 0, 0, 0, 0, N'توضیحاات محصوول', CAST(N'2020-03-17T00:38:54.467' AS DateTime), N'محصوول 1', N'توضیحات سئو', N'کلید واژه سئو', 1, 97, 0, 0)
INSERT [dbo].[tbl_Product] ([id_MProduct], [IS_AVAILABEL], [id_CreatedByAdmin], [id_DraftLevel], [id_Type], [id_MainCategory], [id_SubCategory], [idMPC_WhichTomainPrice], [Description], [DateCreated], [Title], [Seo_Description], [Seo_KeyWords], [IS_AD], [Search_Gravity], [Is_IntheDraft], [ISDELETE]) VALUES (4007, 1, 1, 0, 0, 0, 0, 0, N'توضیحاات محصوول', CAST(N'2020-03-17T01:58:52.733' AS DateTime), N'محصوول 1', N'توضیحات سئو', N'کلید واژه سئو', 1, 100, 0, 0)
INSERT [dbo].[tbl_Product] ([id_MProduct], [IS_AVAILABEL], [id_CreatedByAdmin], [id_DraftLevel], [id_Type], [id_MainCategory], [id_SubCategory], [idMPC_WhichTomainPrice], [Description], [DateCreated], [Title], [Seo_Description], [Seo_KeyWords], [IS_AD], [Search_Gravity], [Is_IntheDraft], [ISDELETE]) VALUES (4008, 1, 1, 0, 1, 1, 1, 0, N'توضیحاات محصوول', CAST(N'2020-03-17T02:25:37.470' AS DateTime), N'محصوول 1', N'توضیحات سئو', N'کلید واژه سئو', 1, 100, 0, 0)
INSERT [dbo].[tbl_Product] ([id_MProduct], [IS_AVAILABEL], [id_CreatedByAdmin], [id_DraftLevel], [id_Type], [id_MainCategory], [id_SubCategory], [idMPC_WhichTomainPrice], [Description], [DateCreated], [Title], [Seo_Description], [Seo_KeyWords], [IS_AD], [Search_Gravity], [Is_IntheDraft], [ISDELETE]) VALUES (4009, 1, 1, 0, 0, 0, 0, 0, N'توضیحاات محصوول', CAST(N'2020-03-17T03:07:57.060' AS DateTime), N'محصوول 1', N'توضیحات سئو', N'کلید واژه سئو', 1, 100, 0, 0)
INSERT [dbo].[tbl_Product] ([id_MProduct], [IS_AVAILABEL], [id_CreatedByAdmin], [id_DraftLevel], [id_Type], [id_MainCategory], [id_SubCategory], [idMPC_WhichTomainPrice], [Description], [DateCreated], [Title], [Seo_Description], [Seo_KeyWords], [IS_AD], [Search_Gravity], [Is_IntheDraft], [ISDELETE]) VALUES (4010, 1, 1, 0, 0, 0, 0, 0, N'توضیحاات محصوول', CAST(N'2020-03-17T03:11:37.583' AS DateTime), N'محصوول 1', N'توضیحات سئو', N'کلید واژه سئو', 1, 100, 0, 0)
INSERT [dbo].[tbl_Product] ([id_MProduct], [IS_AVAILABEL], [id_CreatedByAdmin], [id_DraftLevel], [id_Type], [id_MainCategory], [id_SubCategory], [idMPC_WhichTomainPrice], [Description], [DateCreated], [Title], [Seo_Description], [Seo_KeyWords], [IS_AD], [Search_Gravity], [Is_IntheDraft], [ISDELETE]) VALUES (4011, 1, 1, 0, 0, 0, 0, 0, N'توضیحاات محصوول', CAST(N'2020-03-17T03:13:13.313' AS DateTime), N'محصوول 1', N'توضیحات سئو', N'کلید واژه سئو', 1, 100, 0, 0)
INSERT [dbo].[tbl_Product] ([id_MProduct], [IS_AVAILABEL], [id_CreatedByAdmin], [id_DraftLevel], [id_Type], [id_MainCategory], [id_SubCategory], [idMPC_WhichTomainPrice], [Description], [DateCreated], [Title], [Seo_Description], [Seo_KeyWords], [IS_AD], [Search_Gravity], [Is_IntheDraft], [ISDELETE]) VALUES (4012, 1, 1, 0, 0, 0, 0, 0, N'توضیحاات محصوول', CAST(N'2020-03-17T03:17:16.067' AS DateTime), N'محصوول 1', N'توضیحات سئو', N'کلید واژه سئو', 1, 100, 0, 0)
INSERT [dbo].[tbl_Product] ([id_MProduct], [IS_AVAILABEL], [id_CreatedByAdmin], [id_DraftLevel], [id_Type], [id_MainCategory], [id_SubCategory], [idMPC_WhichTomainPrice], [Description], [DateCreated], [Title], [Seo_Description], [Seo_KeyWords], [IS_AD], [Search_Gravity], [Is_IntheDraft], [ISDELETE]) VALUES (5007, 1, 1, 0, 1, 1, 1, 0, N'توضیحاات محصوول', CAST(N'2020-03-17T22:51:53.660' AS DateTime), N'محصوول 1', N'توضیحات سئو', N'کلید واژه سئو', 1, 100, 0, 0)
INSERT [dbo].[tbl_Product] ([id_MProduct], [IS_AVAILABEL], [id_CreatedByAdmin], [id_DraftLevel], [id_Type], [id_MainCategory], [id_SubCategory], [idMPC_WhichTomainPrice], [Description], [DateCreated], [Title], [Seo_Description], [Seo_KeyWords], [IS_AD], [Search_Gravity], [Is_IntheDraft], [ISDELETE]) VALUES (7017, 1, 1, 0, 1, 1, 1, 0, N'123shDDLAHDL', CAST(N'2020-03-26T18:05:22.530' AS DateTime), N'123df;akhg', N'123skgjhalhg', N'123SHGAGH;h', 1, 100, 0, 1)
INSERT [dbo].[tbl_Product] ([id_MProduct], [IS_AVAILABEL], [id_CreatedByAdmin], [id_DraftLevel], [id_Type], [id_MainCategory], [id_SubCategory], [idMPC_WhichTomainPrice], [Description], [DateCreated], [Title], [Seo_Description], [Seo_KeyWords], [IS_AD], [Search_Gravity], [Is_IntheDraft], [ISDELETE]) VALUES (8016, 1, 1, 0, 1, 1, 1, 0, N'توضیحاات محصوول', CAST(N'2020-04-05T20:19:21.310' AS DateTime), N'محصوول 1', N'توضیحات سئو', N'کلید واژه سئو', 1, 100, 0, 0)
INSERT [dbo].[tbl_Product] ([id_MProduct], [IS_AVAILABEL], [id_CreatedByAdmin], [id_DraftLevel], [id_Type], [id_MainCategory], [id_SubCategory], [idMPC_WhichTomainPrice], [Description], [DateCreated], [Title], [Seo_Description], [Seo_KeyWords], [IS_AD], [Search_Gravity], [Is_IntheDraft], [ISDELETE]) VALUES (8017, 1, 1, 0, 1, 1, 1, 0, N'توضیحاات محصوول', CAST(N'2020-04-06T02:26:52.953' AS DateTime), N'محصوول 1', N'توضیحات سئو', N'کلید واژه سئو', 1, 10, 0, 0)
SET IDENTITY_INSERT [dbo].[tbl_Product] OFF
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1, 1)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1, 1)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1, 4)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (3, 2)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (4, 2)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (4, 5)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1002, 2)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1002, 4)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1003, 2)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1003, 5)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1004, 3)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1004, 4)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1005, 3)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1005, 5)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1006, 2)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1007, 3)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1, 1)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1, 1)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1, 4)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (3, 2)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (4, 2)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (4, 5)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1002, 2)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1002, 4)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1003, 2)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1003, 5)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1004, 3)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1004, 4)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1005, 3)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1005, 5)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1006, 2)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1007, 3)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (3, 4)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (5, 3)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (5, 4)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (6, 3)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (6, 5)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1, 1)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1, 1)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1, 4)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (3, 2)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (4, 2)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (4, 5)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1002, 2)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1002, 4)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1003, 2)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1003, 5)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1004, 3)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1004, 4)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1005, 3)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1005, 5)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1006, 2)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (1007, 3)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (3, 4)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (5, 3)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (5, 4)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (6, 3)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (6, 5)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (2002, 1)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (2003, 2)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (3002, 2616)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (3002, 2624)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (3003, 2616)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (3003, 2626)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (3004, 2617)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (3004, 2624)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (3005, 2617)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (3005, 2626)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (4002, 2661)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (4002, 2616)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (3, 4)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (5, 3)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (5, 4)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (6, 3)
INSERT [dbo].[tbl_Product_connectorToMPC_SCOV] ([id_MPC], [id_SCOV]) VALUES (6, 5)
SET IDENTITY_INSERT [dbo].[tbl_Product_MainCategory] ON 

INSERT [dbo].[tbl_Product_MainCategory] ([id_MC], [id_PT], [MCName], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (1, 1, N'گوشی موبایل', 0, 0, NULL, CAST(N'2020-02-28T13:54:14.540' AS DateTime))
INSERT [dbo].[tbl_Product_MainCategory] ([id_MC], [id_PT], [MCName], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (2, 1003, N'پارچه', 0, 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_Product_MainCategory] OFF
SET IDENTITY_INSERT [dbo].[tbl_Product_MainStarTags] ON 

INSERT [dbo].[tbl_Product_MainStarTags] ([id_MainStarTag], [MST_Description], [MST_Name]) VALUES (2, N'فروش ویژه ی بهاره', N'فروش ویژه')
INSERT [dbo].[tbl_Product_MainStarTags] ([id_MainStarTag], [MST_Description], [MST_Name]) VALUES (1002, N'fsaaaas', N'sfaa')
SET IDENTITY_INSERT [dbo].[tbl_Product_MainStarTags] OFF
SET IDENTITY_INSERT [dbo].[tbl_Product_MoneyType] ON 

INSERT [dbo].[tbl_Product_MoneyType] ([MoneyId], [MoneyTypeName]) VALUES (1, N'ریال')
INSERT [dbo].[tbl_Product_MoneyType] ([MoneyId], [MoneyTypeName]) VALUES (2, N'تومان')
INSERT [dbo].[tbl_Product_MoneyType] ([MoneyId], [MoneyTypeName]) VALUES (3, N'دلار')
INSERT [dbo].[tbl_Product_MoneyType] ([MoneyId], [MoneyTypeName]) VALUES (4, N'یورو')
SET IDENTITY_INSERT [dbo].[tbl_Product_MoneyType] OFF
INSERT [dbo].[tbl_Product_OffType] ([OffType], [OffType_Description], [OffType_Symbol]) VALUES (1, N'تخفیف ندارد', N' بدون تخفیف')
INSERT [dbo].[tbl_Product_OffType] ([OffType], [OffType_Description], [OffType_Symbol]) VALUES (2, N'%', N'درصدی')
INSERT [dbo].[tbl_Product_OffType] ([OffType], [OffType_Description], [OffType_Symbol]) VALUES (3, N'ثابت', N'مقدار ثابت')
SET IDENTITY_INSERT [dbo].[tbl_Product_PastProductHistory] ON 

INSERT [dbo].[tbl_Product_PastProductHistory] ([id_PPH], [id_MPC], [PriceXquantity], [PricePerquantity], [PriceOff], [OffType], [id_MainStarTag], [ChangedDate]) VALUES (1, 1, 2, 3, 4, 1, 1, CAST(N'2020-03-27T15:50:39.573' AS DateTime))
INSERT [dbo].[tbl_Product_PastProductHistory] ([id_PPH], [id_MPC], [PriceXquantity], [PricePerquantity], [PriceOff], [OffType], [id_MainStarTag], [ChangedDate]) VALUES (2, 1002, 23, 23, 23, 1, 2, CAST(N'2020-03-27T16:11:25.367' AS DateTime))
INSERT [dbo].[tbl_Product_PastProductHistory] ([id_PPH], [id_MPC], [PriceXquantity], [PricePerquantity], [PriceOff], [OffType], [id_MainStarTag], [ChangedDate]) VALUES (1002, 4002, 1, 1, 1, 1, 2, CAST(N'2020-04-05T20:20:31.553' AS DateTime))
INSERT [dbo].[tbl_Product_PastProductHistory] ([id_PPH], [id_MPC], [PriceXquantity], [PricePerquantity], [PriceOff], [OffType], [id_MainStarTag], [ChangedDate]) VALUES (1003, 4002, 1, 1, 1, 1, 2, CAST(N'2020-04-05T20:21:43.893' AS DateTime))
SET IDENTITY_INSERT [dbo].[tbl_Product_PastProductHistory] OFF
SET IDENTITY_INSERT [dbo].[tbl_Product_Pic] ON 

INSERT [dbo].[tbl_Product_Pic] ([PicID], [id_MProduct], [BigPicAddress], [ThumbnailPicAddress], [ISDELETE], [alt], [uploadPicName], [Descriptions]) VALUES (1, 4, N'/assets/download.jpg', N'/assets/download.jpg', 0, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_Product_Pic] OFF
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (3007, 1012)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (4007, 12)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (4007, 13)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (4008, 12)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (4008, 13)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (5007, 12)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (5007, 13)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (6007, 2012)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (6008, 2013)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (1, 2012)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (1, 3012)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (4009, 12)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (4009, 13)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (4010, 12)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (4010, 13)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (4011, 12)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (4011, 13)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (4012, 12)
INSERT [dbo].[tbl_Product_PicConnector] ([id_MProduct], [PicID]) VALUES (4012, 13)
SET IDENTITY_INSERT [dbo].[tbl_Product_PriceShow] ON 

INSERT [dbo].[tbl_Product_PriceShow] ([PriceShowId], [PriceShowformat]) VALUES (1, N'{a}')
INSERT [dbo].[tbl_Product_PriceShow] ([PriceShowId], [PriceShowformat]) VALUES (2, N'{000,000}')
SET IDENTITY_INSERT [dbo].[tbl_Product_PriceShow] OFF
SET IDENTITY_INSERT [dbo].[tbl_Product_ProductQuantityType] ON 

INSERT [dbo].[tbl_Product_ProductQuantityType] ([id_PQT], [PQT_Description], [PQT_Demansion], [PQT_Quantom]) VALUES (1, NULL, N'جین', 6)
INSERT [dbo].[tbl_Product_ProductQuantityType] ([id_PQT], [PQT_Description], [PQT_Demansion], [PQT_Quantom]) VALUES (2, NULL, N'کیلو', 1)
INSERT [dbo].[tbl_Product_ProductQuantityType] ([id_PQT], [PQT_Description], [PQT_Demansion], [PQT_Quantom]) VALUES (3, NULL, N'تن', 1)
INSERT [dbo].[tbl_Product_ProductQuantityType] ([id_PQT], [PQT_Description], [PQT_Demansion], [PQT_Quantom]) VALUES (4, NULL, N'بسته', 1)
SET IDENTITY_INSERT [dbo].[tbl_Product_ProductQuantityType] OFF
SET IDENTITY_INSERT [dbo].[tbl_Product_SubCategory] ON 

INSERT [dbo].[tbl_Product_SubCategory] ([id_SC], [id_MC], [SCName], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (1, 1, N'سامسونگ', 0, 0, NULL, CAST(N'2020-02-28T13:58:10.660' AS DateTime))
SET IDENTITY_INSERT [dbo].[tbl_Product_SubCategory] OFF
SET IDENTITY_INSERT [dbo].[tbl_Product_SubCategoryOptionKey] ON 

INSERT [dbo].[tbl_Product_SubCategoryOptionKey] ([id_SCOK], [id_SC], [SCOKName], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (1044, 1, N'تولید کننده', 0, 0, NULL, NULL)
INSERT [dbo].[tbl_Product_SubCategoryOptionKey] ([id_SCOK], [id_SC], [SCOKName], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (1045, 1, N'جنسیت', 0, 0, NULL, NULL)
INSERT [dbo].[tbl_Product_SubCategoryOptionKey] ([id_SCOK], [id_SC], [SCOKName], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (1046, 1, N'سایز', 0, 0, NULL, NULL)
INSERT [dbo].[tbl_Product_SubCategoryOptionKey] ([id_SCOK], [id_SC], [SCOKName], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (1047, 1, N'رنگ', 0, 0, NULL, NULL)
INSERT [dbo].[tbl_Product_SubCategoryOptionKey] ([id_SCOK], [id_SC], [SCOKName], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (1048, 1, N'نوع', 0, 0, NULL, NULL)
INSERT [dbo].[tbl_Product_SubCategoryOptionKey] ([id_SCOK], [id_SC], [SCOKName], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (1049, 1, N'جنس رویه', 0, 0, NULL, NULL)
INSERT [dbo].[tbl_Product_SubCategoryOptionKey] ([id_SCOK], [id_SC], [SCOKName], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (1050, 1, N'لایه داخلی', 0, 0, NULL, NULL)
INSERT [dbo].[tbl_Product_SubCategoryOptionKey] ([id_SCOK], [id_SC], [SCOKName], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (1051, 1, N'جنس زیره', 0, 0, NULL, NULL)
INSERT [dbo].[tbl_Product_SubCategoryOptionKey] ([id_SCOK], [id_SC], [SCOKName], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (1052, 1, N'حداقل میزان خرید', 0, 0, NULL, NULL)
INSERT [dbo].[tbl_Product_SubCategoryOptionKey] ([id_SCOK], [id_SC], [SCOKName], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (1053, 1, N'تعداد در کارتن', 0, 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_Product_SubCategoryOptionKey] OFF
SET IDENTITY_INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ON 

INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (1, 1, N'gold')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2, 1, N'silver')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (3, 1, N'roze gold')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (4, 2, N'galaxy s8')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (5, 2, N'galaxy A3')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (6, 1, N'black')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (7, 1, N'white')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (8, 1, N'pink')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2431, 1, N'آبی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2432, 1, N' بژ ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2433, 1, N' پسته ای ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2434, 1, N' پلنگی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2435, 1, N' تکاوری ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2436, 1, N' خاکی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2437, 1, N' زرشکی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2438, 1, N' زیتونی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2439, 1, N' سبز ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2440, 1, N' سرخابی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2441, 1, N' سرمه ای ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2442, 1, N' سفید ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2443, 1, N' طلایی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2444, 1, N' فیروزه ای ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2445, 1, N' فیلی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2446, 1, N' قرمز ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2447, 1, N' قهوه ای- عسلی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2448, 1, N' کالباسی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2449, 1, N' کرم ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2450, 1, N' کرم- سفید ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2451, 1, N' کرم- قهوه ای ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2452, 1, N' کویری ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2453, 1, N' گردویی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2454, 1, N' گلبهی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2455, 1, N' لیمویی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2456, 1, N' مشکی- کلار ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2457, 1, N' مشکی- آبی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2458, 1, N' مشکی- سبز ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2459, 1, N' مشکی- طوسی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2460, 1, N' مشکی- طوسی- قرمز ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2461, 1, N' مشکی- قرمز ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2462, 1, N' نارنجی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2463, 1, N' نباتی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2464, 1, N' نسکافه ای ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2465, 1, N' نوک مدادی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2466, 1, N' یاسی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2467, 1, N' الوان ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2468, 1, N' طوسی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2469, 1, N' عسلی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2470, 1, N' قهوه ای ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2471, 1, N' کاراملی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2472, 1, N' مشکی')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2574, 1047, N'آبی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2575, 1047, N' بژ ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2576, 1047, N' پسته ای ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2577, 1047, N' پلنگی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2578, 1047, N' تکاوری ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2579, 1047, N' خاکی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2580, 1047, N' زرشکی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2581, 1047, N' زیتونی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2582, 1047, N' سبز ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2583, 1047, N' سرخابی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2584, 1047, N' سرمه ای ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2585, 1047, N' سفید ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2586, 1047, N' طلایی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2587, 1047, N' فیروزه ای ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2588, 1047, N' فیلی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2589, 1047, N' قرمز ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2590, 1047, N' قهوه ای- عسلی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2591, 1047, N' کالباسی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2592, 1047, N' کرم ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2593, 1047, N' کرم- سفید ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2594, 1047, N' کرم- قهوه ای ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2595, 1047, N' کویری ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2596, 1047, N' گردویی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2597, 1047, N' گلبهی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2598, 1047, N' لیمویی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2599, 1047, N' مشکی- کلار ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2600, 1047, N' مشکی- آبی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2601, 1047, N' مشکی- سبز ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2602, 1047, N' مشکی- طوسی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2603, 1047, N' مشکی- طوسی- قرمز ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2604, 1047, N' مشکی- قرمز ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2605, 1047, N' نارنجی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2606, 1047, N' نباتی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2607, 1047, N' نسکافه ای ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2608, 1047, N' نوک مدادی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2609, 1047, N' یاسی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2610, 1047, N' الوان ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2611, 1047, N' طوسی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2612, 1047, N' عسلی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2613, 1047, N' قهوه ای ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2614, 1047, N' کاراملی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2615, 1047, N' مشکی')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2616, 1045, N'مردانه ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2617, 1045, N' زنانه ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2618, 1045, N' پسرانه ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2619, 1045, N' دخترانه ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2620, 1045, N' اسپورت')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2621, 1046, N'26 تا 31')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2622, 1046, N'32 تا 36')
GO
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2623, 1046, N'36 تا 40')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2624, 1046, N'36 تا 41')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2625, 1046, N'37 تا 40')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2626, 1046, N'37 تا 41')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2627, 1046, N'37 تا 42')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2628, 1046, N'38')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2629, 1046, N'38 تا 48')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2630, 1046, N'39')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2631, 1046, N'40')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2632, 1046, N'40 تا 42')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2633, 1046, N'40 تا 44')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2634, 1046, N'40 تا 45')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2635, 1046, N'40 تا 46')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2636, 1046, N'41')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2637, 1046, N'41 تا 45')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2638, 1046, N'42')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2639, 1046, N'42 تا 45')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2640, 1046, N'43')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2641, 1046, N'44')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2642, 1046, N'45')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2643, 1046, N'45 تا 47')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2644, 1046, N'48 تا 48')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2645, 1046, N'46')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2646, 1046, N'47')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2647, 1046, N'48')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2648, 1048, N'بدون بند ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2649, 1048, N' بندی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2650, 1048, N' بدون پد سیلیکونی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2651, 1048, N' با پد سیلیکونی')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2652, 1049, N'پارچه ای ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2653, 1049, N' چرم صنعتی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2654, 1049, N' چرم طبیعی گاوی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2655, 1049, N' فوم ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2656, 1049, N' کنف ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2657, 1049, N' نبوک طبیعی ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2658, 1049, N' فوم طرح چرم')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2659, 1050, N'فوم ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2660, 1050, N'چرم طبیعی بزی')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2661, 1044, N'شهپر ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2662, 1044, N' شیما ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2663, 1044, N' پازین')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2664, 1051, N'PU')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2665, 1051, N'PU دو دانسیته')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2666, 1051, N'TPU')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2667, 1052, N'یک کارتن')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2668, 1053, N' 8 ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2669, 1053, N' 9 ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2670, 1053, N' 10 ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2671, 1053, N' 12 ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2672, 1053, N' 16 ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2673, 1053, N' 18 ')
INSERT [dbo].[tbl_Product_SubCategoryOptionValue] ([id_SCOV], [id_SCOK], [SCOVValueName]) VALUES (2674, 1053, N' 24 ')
SET IDENTITY_INSERT [dbo].[tbl_Product_SubCategoryOptionValue] OFF
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (1, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (2, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (3, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (4, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (5, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (6, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (1, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (2, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (3, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (4, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (5, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (6, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (1, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (2, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (3, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (4, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (5, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (6, 1)
INSERT [dbo].[tbl_Product_tagConnector] ([id_MPC], [id_TE]) VALUES (4002, 3)
SET IDENTITY_INSERT [dbo].[tbl_Product_TagEnums] ON 

INSERT [dbo].[tbl_Product_TagEnums] ([id_TE], [TE_name], [SubCatId]) VALUES (1, N'موبایل', 1)
INSERT [dbo].[tbl_Product_TagEnums] ([id_TE], [TE_name], [SubCatId]) VALUES (2, N'ساعت هوشمند', 1)
INSERT [dbo].[tbl_Product_TagEnums] ([id_TE], [TE_name], [SubCatId]) VALUES (3, N'تبلت', 1)
SET IDENTITY_INSERT [dbo].[tbl_Product_TagEnums] OFF
SET IDENTITY_INSERT [dbo].[tbl_Product_tblOptions] ON 

INSERT [dbo].[tbl_Product_tblOptions] ([id_Op], [id_MProduct], [KeyName], [Value]) VALUES (2, 1, N'باتری', N'2600')
INSERT [dbo].[tbl_Product_tblOptions] ([id_Op], [id_MProduct], [KeyName], [Value]) VALUES (3, 1, N'وزن', N'200گرم')
INSERT [dbo].[tbl_Product_tblOptions] ([id_Op], [id_MProduct], [KeyName], [Value]) VALUES (4, 1, N'android', N'8')
INSERT [dbo].[tbl_Product_tblOptions] ([id_Op], [id_MProduct], [KeyName], [Value]) VALUES (1002, 1008, N'وزن', N'200')
INSERT [dbo].[tbl_Product_tblOptions] ([id_Op], [id_MProduct], [KeyName], [Value]) VALUES (2002, 2005, N'لللللل', N'سیشب')
INSERT [dbo].[tbl_Product_tblOptions] ([id_Op], [id_MProduct], [KeyName], [Value]) VALUES (3002, 5007, N'ایتم 1', N'مقدار 1')
INSERT [dbo].[tbl_Product_tblOptions] ([id_Op], [id_MProduct], [KeyName], [Value]) VALUES (3003, 5007, N'ایتم 2', N'مقدار 2')
INSERT [dbo].[tbl_Product_tblOptions] ([id_Op], [id_MProduct], [KeyName], [Value]) VALUES (4002, 6007, N'ایتم 1', N'مقدار 1')
INSERT [dbo].[tbl_Product_tblOptions] ([id_Op], [id_MProduct], [KeyName], [Value]) VALUES (4003, 6007, N'ایتم 2', N'مقدار 2')
INSERT [dbo].[tbl_Product_tblOptions] ([id_Op], [id_MProduct], [KeyName], [Value]) VALUES (4004, 6008, N'آیتم 1', N'مقدار 1')
INSERT [dbo].[tbl_Product_tblOptions] ([id_Op], [id_MProduct], [KeyName], [Value]) VALUES (4005, 6008, N'مقدار 2', N'ایتم 2')
INSERT [dbo].[tbl_Product_tblOptions] ([id_Op], [id_MProduct], [KeyName], [Value]) VALUES (5002, 7017, N'asl;fjf', N'123s;dhgal')
SET IDENTITY_INSERT [dbo].[tbl_Product_tblOptions] OFF
SET IDENTITY_INSERT [dbo].[tbl_Product_Type] ON 

INSERT [dbo].[tbl_Product_Type] ([id_PT], [PTname], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (1, N'وسایل دیجیتال', 0, 0, NULL, NULL)
INSERT [dbo].[tbl_Product_Type] ([id_PT], [PTname], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (2, N'خوراکی', 0, 0, NULL, NULL)
INSERT [dbo].[tbl_Product_Type] ([id_PT], [PTname], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (3, N'پوشاک', 0, 0, CAST(N'2020-02-20T12:01:11.300' AS DateTime), NULL)
INSERT [dbo].[tbl_Product_Type] ([id_PT], [PTname], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (4, N'دیگر', 0, 0, CAST(N'2020-02-20T08:01:10.823' AS DateTime), NULL)
INSERT [dbo].[tbl_Product_Type] ([id_PT], [PTname], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (1003, N'other', 0, 1, NULL, NULL)
INSERT [dbo].[tbl_Product_Type] ([id_PT], [PTname], [ISDESABLED], [ISDelete], [DateDesabled], [DateDeleted]) VALUES (1004, N'dfss', 1, 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_Product_Type] OFF
SET IDENTITY_INSERT [dbo].[tbl_UserController_UserTypes] ON 

INSERT [dbo].[tbl_UserController_UserTypes] ([UserTypeID], [UserTypeName]) VALUES (1, N'Admin')
INSERT [dbo].[tbl_UserController_UserTypes] ([UserTypeID], [UserTypeName]) VALUES (2, N'Customer')
SET IDENTITY_INSERT [dbo].[tbl_UserController_UserTypes] OFF
SET IDENTITY_INSERT [dbo].[tlb_Product_MainProductConnector] ON 

INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (1, 1, 11, 121, 11, 121, 0, 1, 2, 0, 0, 4, CAST(N'2020-03-09T20:22:37.910' AS DateTime), 1, 1, N'<p>age matni dashti bayad inja benevisish!!!</p>')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (2, 1, 2, 44, 22, 44, 0, 44, 2, 0, 0, 4, CAST(N'2020-03-09T20:28:19.693' AS DateTime), 1, 1, N'<p>age matni dashti bayad inja benevisish!!!</p>')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (3, 1, 11, 1221, 111, 1221, 0, 1, 2, 1, 0, 4, CAST(N'2020-03-09T20:43:07.580' AS DateTime), 1, 1, N'<p>age matni dashti bayad inja benevisish!!!</p>')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (4, 1, 11, 1221, 111, 1221, 0, 1, 2, 0, 0, 4, CAST(N'2020-03-09T20:43:13.560' AS DateTime), 1, 1, N'<p>age matni dashti bayad inja benevisish!!!</p>')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (5, 1, 11, 1221, 111, 1221, 0, 1, 2, 1, 0, 4, CAST(N'2020-03-09T20:43:17.017' AS DateTime), 1, 1, N'<p>age matni dashti bayad inja benevisish!!!</p>')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (6, 1, 11, 1221, 111, 1221, 0, 1, 2, 0, 0, 4, CAST(N'2020-03-09T20:43:20.740' AS DateTime), 1, 1, N'<p>age matni dashti bayad inja benevisish!!!</p>')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (1002, 1006, 1, 23, 23, 23, 0, 23, 2, 0, 0, 4, CAST(N'2020-03-10T19:01:11.507' AS DateTime), 1, 1, N' ')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (1003, 1006, 213, 2369199, 11123, 2369199, 0, 1, 2, 0, 0, 4, CAST(N'2020-03-10T19:01:14.307' AS DateTime), 1, 1, N' ')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (1004, 1006, 213, 2369199, 11123, 2369199, 0, 1, 2, 0, 0, 4, CAST(N'2020-03-10T19:01:15.980' AS DateTime), 1, 1, N' ')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (1005, 1006, 213, 2369199, 11123, 2369199, 0, 1, 2, 0, 0, 4, CAST(N'2020-03-10T19:01:17.107' AS DateTime), 1, 1, N' ')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (1006, 1007, 1, 123, 123, 123, 0, 1, 2, 0, 0, 4, CAST(N'2020-03-10T19:12:36.430' AS DateTime), 1, 1, N' ')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (1007, 1007, 1, 123, 123, 123, 0, 1, 2, 0, 0, 4, CAST(N'2020-03-10T19:12:36.463' AS DateTime), 1, 1, N' ')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (2002, 2005, 1, 1111, 1111, 1111, 0, 1111, 2, 0, 0, 3, CAST(N'2020-03-12T20:33:46.430' AS DateTime), 2, 1, N' ')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (2003, 2005, 1, 1111, 1111, 1111, 0, 1, 2, 1, 0, 4, CAST(N'2020-03-12T20:33:46.483' AS DateTime), 1, 1, N' ')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (3002, 7017, 111, 1332, 12, 1332, 0, 1332, 2, 0, 0, 4, CAST(N'2020-03-27T15:47:37.453' AS DateTime), 1, 1, N' ')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (3003, 7017, 111, 111, 1, 111, 0, 1, 2, 0, 0, 4, CAST(N'2020-03-27T15:47:37.580' AS DateTime), 1, 1, N' ')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (3004, 7017, 111, 111, 1, 111, 0, 1, 2, 0, 0, 4, CAST(N'2020-03-27T15:47:37.703' AS DateTime), 1, 1, N' ')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (3005, 7017, 111, 111, 1, 111, 0, 1, 2, 0, 0, 4, CAST(N'2020-03-27T15:47:37.813' AS DateTime), 1, 1, N' ')
INSERT [dbo].[tlb_Product_MainProductConnector] ([id_MPC], [id_MProduct], [Quantity], [PriceXquantity], [PricePerquantity], [PriceOff], [offTypeValue], [OffType], [id_MainStarTag], [ISDELETE], [OutOfStock], [id_PQT], [DateToRelease], [PriceModule], [PriceShow], [describtion]) VALUES (4002, 8016, 1, 1, 1, 1, 0, 1, 2, 0, 0, 4, CAST(N'2020-04-05T20:20:31.523' AS DateTime), 1, 1, N' ')
SET IDENTITY_INSERT [dbo].[tlb_Product_MainProductConnector] OFF
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
         Begin Table = "tbl_ADMIN_UploadStructure_ImageAddress"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 409
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_ADMIN_UploaderStructure_ImageSize"
            Begin Extent = 
               Top = 163
               Left = 301
               Bottom = 293
               Right = 487
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_ADMIN_UploaderStructure_CategoryPic"
            Begin Extent = 
               Top = 177
               Left = 713
               Bottom = 304
               Right = 923
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_ADMIN_UploaderStructure"
            Begin Extent = 
               Top = 6
               Left = 752
               Bottom = 136
               Right = 930
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_Product_PicConnector"
            Begin Extent = 
               Top = 48
               Left = 956
               Bottom = 144
               Right = 1126
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
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_Images'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_Images'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_Images'
GO
