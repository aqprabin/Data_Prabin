CREATE TABLE [dbo].[Product]
(
[TransactionID] [int] NOT NULL,
[Product] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Quantity] [int] NULL,
[Amount] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [PK__Product__55433A4BF1D3B212] PRIMARY KEY CLUSTERED ([TransactionID]) ON [PRIMARY]
GO
