
Declare @Date as DateTime

Set @Date = DATEADD(mi,30,DATEADD(hh,5,GETDATE()))-1

select row_number()over(order by TaskDescription) as RID ,* into #temp1 from dbo.VW_PBI_ExceptionData 
 Where Cast(@Date as Date) = CreatedDate 


declare
@RowCount int=0,
@Cnt int=0,
@var int=1,
@A int=1



select @RowCount=count(*) from #temp1


if(@RowCount%150)=0
begin
set @Cnt=(@RowCount/150)
end
else
begin
set @Cnt=(@RowCount/150)+1
end



create table #temp (RID int,Json_Result varchar(8000))

while(@var <= @Cnt)
begin
;with step1 as(

SELECT  RID,CONCAT('',CONCAT('{"TaskDescription":"',[TaskDescription],'","ExceptionCode":"',[ExceptionCode],'","Division":"',[Division],'","Level":"',[Level],'","AccountID":"',[AccountID],'","ExceptionClass":"',[ExceptionClass],'","ExceptionSubClass":"',[ExceptionSubClass],'","StartDate":"',[StartDate],'","ExceptionCode":"',[ExceptionCode],'","DueDate":"',[DueDate],'","CreatedDate":"',[CreatedDate],'","UpdatedDate":"',[UpdatedDate],'","Flag":"',[Flag],'","ExceptionType":"',[ExceptionType],'"}')) as Json_Result            
     FROM #temp1
	 )
	 insert into #temp
	 select * from step1 where RID >= @A and RID <= @A+149
	  
	  set @A=@A+150
set @var=@var+1
end


	declare @first_string nvarchar(MAX)
	,@second_string nvarchar(MAX)
	,@Semi_Final nvarchar(MAX) = ''
	,@Final nvarchar(MAX) = ''
	,@abc int=150
	,@xyz int=300
	,@A1 int=0
	,@cnt1 int=0
	,@var1 int=1
	,@RowCount1 int
	--,@Date1 datetime
	Set @first_string = 'SELECT ''['' + STRING_AGG(CONVERT(nvarchar(max), Json_Result), '','') +'']'' AS Json_Result from #temp where RID > '
	+convert(nvarchar(20),@A1)+' and RID <= '+convert(nvarchar(20),@abc)+''


	select @RowCount1=count(*) from #temp


if(@RowCount1%150)=0
begin
set @cnt1=(@RowCount1/150)
end
else
begin
set @cnt1=(@RowCount1/150)+1
end
	


	while(@var1 < @cnt1)
	begin

	Set @Second_string = ' union all
	SELECT ''['' + STRING_AGG(CONVERT(nvarchar(max), Json_Result), '','') +'']'' AS Json_Result from #temp where RID > '+convert(nvarchar(20),@abc)+' and RID <= '+convert(nvarchar(20),@xyz)+''
	Set @semi_final = @Semi_Final + @Second_String
	set @abc=@abc+150
	set @xyz=@abc+150
	set @var1=@var1+1
	end
	Set @Final = @First_String + @Semi_Final
	exec(@Final)

	   
drop table #temp
drop table #temp1


