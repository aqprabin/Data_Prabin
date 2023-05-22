CREATE TABLE [dbo].[ContactInfo]
(
[ContactInfoID] [int] NOT NULL IDENTITY(1, 1),
[PersonID] [int] NULL,
[Email] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Phone] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Fax] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Website] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContactInfo] ADD CONSTRAINT [PK__ContactI__7B7333D977833697] PRIMARY KEY CLUSTERED ([ContactInfoID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContactInfo] ADD CONSTRAINT [FK__ContactIn__Perso__29572725] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
