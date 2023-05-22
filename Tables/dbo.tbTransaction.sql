CREATE TABLE [dbo].[tbTransaction]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[age] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbTransaction] ADD CONSTRAINT [PK__tbTransa__3213E83FFBCDD816] PRIMARY KEY CLUSTERED ([id]) ON [PRIMARY]
GO
