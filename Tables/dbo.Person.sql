CREATE TABLE [dbo].[Person]
(
[PersonID] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Gender] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BirthDate] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Person] ADD CONSTRAINT [PK__Person__AA2FFB85A7FA5EEA] PRIMARY KEY CLUSTERED ([PersonID]) ON [PRIMARY]
GO
