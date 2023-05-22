CREATE TABLE [dbo].[Address]
(
[AddressID] [int] NOT NULL IDENTITY(1, 1),
[PersonID] [int] NULL,
[AddressLine1] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AddressLine2] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StateProvince] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PostalCode] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Country] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Address] ADD CONSTRAINT [PK__Address__091C2A1BC397BE50] PRIMARY KEY CLUSTERED ([AddressID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Address] ADD CONSTRAINT [FK__Address__PersonI__267ABA7A] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
