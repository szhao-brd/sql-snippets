CREATE OR ALTER PROCEDURE [dbo].[usp_DynamicSQL_SchemaMapping_ColumnListGenerator]
	@Schema VARCHAR(255),
	@Table VARCHAR(255)
AS
DECLARE @COLUMN_LIST NVARCHAR(MAX);
SELECT @COLUMN_LIST = (
	SELECT
		c.SourceColumnName + ' AS ' + c.TargetColumnName + ','
	FROM
		ASTRIA.[tbl_ADF_Meta_Conformance_SchemaMappingControlTable] as c
	WHERE
			c.SourceDatabaseName = 'joiststats'
		AND c.SourceTableSchemaName = @Schema
		AND c.SourceTableName = @Table FOR XML PATH('')
)	

SELECT
	LEFT(@COLUMN_LIST, LEN(@COLUMN_LIST) - 1)			
AS COLUMN_LIST