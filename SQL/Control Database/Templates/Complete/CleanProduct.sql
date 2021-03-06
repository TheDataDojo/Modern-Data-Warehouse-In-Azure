
DROP PROC IF EXISTS SalesSystem.CleanProduct
GO

CREATE PROC SalesSystem.CleanProduct
(
    @LoadId INTEGER = NULL
)

AS
BEGIN

    DROP TABLE IF EXISTS #Product
	
	TRUNCATE TABLE Stage.Product

	BEGIN TRY

		SELECT
             @LoadId AS LoadId
            ,GETDATE() AS LoadDate
		    
		INTO #Product
		FROM
		    Stage.Product

		INSERT INTO Clean.Product
		SELECT
			 LoadId
            ,GETDATE() AS LoadDate
			
		FROM
			#Product

	END TRY

	BEGIN CATCH
		
		RAISERROR('Could not complete the clean / rules step for SalesSystem.Product',1,1);

	END CATCH

