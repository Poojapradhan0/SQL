
--------------SQL Portfolio Project Indian Census------------------

 use project
 Go

 
 select *  from project.dbo.Data1

 select * from project.dbo.Data2

 -- Number of rows in our dataset

 select count(*) from Data1 
  select count(*) from Data2

  --Dataset for jharkhand and bihar
  select * from Data1 where state in ('jharkhand' ,'bihar' )

  -- total popultion of india
  select * from Data2
  select sum(population) as  population from Data2
  select max(population) as  population from Data2
 select min(population) as  population from Data2
   select sum(population) as  population from Data2
select avg(population) from data2


  --average growth
    select * from Data1
	select avg(growth) AS average_growth from data1
	  
 select  State, avg(growth) AS average_growth 
 from data1
 group by State

   --average sex ratio
   select state, round(AVG(sex_ratio),0) as avg_sex_ratio from Data1
   group by state
   order by avg_sex_ratio desc;

   --Average literacy ratio

   select state, round(avg(literacy),0) as avg_literacy from Data1
   group by state
   order by avg_literacy desc;

   select state, round(avg(literacy),0) as avg_literacy from Data1			-- add having 
   group by state HAVING round(avg(literacy),0) >90
   order by avg_literacy desc;

   select  top 3 state, round(avg(literacy),0) as avg_literacy from Data1			--top 3 state 
   group by state
   order by avg_literacy desc;

   --Bottom 3 state showing lowest sex ratio
   select  top 3 state, round(avg(Sex_ratio),0) AS avg_Sex_ratio from Data1
   group by state
   order by avg_Sex_ratio asc;

   --top and bottom 3 states in literacy state
    
	--TOP
	drop table if exists #topstates
   create table #topstates
   (
   state nvarchar(255),
   topstates int
   )
   insert into #topstates
   select state, round(avg(Literacy),0) AS avg_Literacy_ratio from Data1
   group by state
   order by avg_Literacy_ratio desc;

   select top 3 * from #topstates order by #topstates.topstates desc;

   --BUTTOM
   drop table if exists #buttomstates
   create table #buttomstates
   (
   state nvarchar (250),
   topstates float
   )

   insert into #buttomstates 
   select state, round(avg(Literacy),0) AS avg_Literacy_ratio from Data1
   group by state
   order by avg_Literacy_ratio desc;

   select top 3 * from #buttomstates order by #buttomstates.topstates asc;

  --- union operator to join these two tables
  select * from (
      select top 3 * from #topstates order by #topstates.topstates desc) A
	  union
	  select * from (
   select top 3 * from #buttomstates order by #buttomstates.topstates asc)B ;

   ---states starting with letter A
   Select  distinct state from data1 where lower(state) like 'a%' or lower (state) like 'b%'
     
 -- joinnig both table &
 --(Calculating total number of males and total number of females)

select * from Data1
select * from Data2


select D.State , sum(D.males) As Total_Males, Sum(D.females) as Total_Females from
(Select C.district ,C.State, ROUND(C.population/(C.sex_ratio + 1),0) males,
	ROUND((C.population*sex_ratio)/(C.sex_ratio + 1),0) females from 

(select A.District ,A.State,A.sex_ratio/1000 sex_ratio ,B.Population from data1 A
 inner join data2  B
 on A.District = B.district) C ) D
 Group by D.State;

 -- total literacy rate


select c.state,sum(literate_people) total_literate_pop,sum(illiterate_people) total_lliterate_pop from 
(select d.district,d.state,round(d.literacy_ratio*d.population,0) literate_people,
round((1-d.literacy_ratio)* d.population,0) illiterate_people from
(select a.district,a.state,a.literacy/100 literacy_ratio,b.population from project..data1 a 
inner join project..data2 b on a.district=b.district) d) c
group by c.state

-- population in previous census


select sum(m.previous_census_population) previous_census_population,sum(m.current_census_population) current_census_population from(
select e.state,sum(e.previous_census_population) previous_census_population,sum(e.current_census_population) current_census_population from
(select d.district,d.state,round(d.population/(1+d.growth),0) previous_census_population,d.population current_census_population from
(select a.district,a.state,a.growth growth,b.population from project..data1 a inner join project..data2 b on a.district=b.district) d) e
group by e.state)m


-- population vs area

select (g.total_area/g.previous_census_population)  as previous_census_population_vs_area, (g.total_area/g.current_census_population) as 
current_census_population_vs_area from
(select q.*,r.total_area from (

select '1' as keyy,n.* from
(select sum(m.previous_census_population) previous_census_population,sum(m.current_census_population) current_census_population from(
select e.state,sum(e.previous_census_population) previous_census_population,sum(e.current_census_population) current_census_population from
(select d.district,d.state,round(d.population/(1+d.growth),0) previous_census_population,d.population current_census_population from
(select a.district,a.state,a.growth growth,b.population from project..data1 a inner join project..data2 b on a.district=b.district) d) e
group by e.state)m) n) q inner join (

select '1' as keyy,z.* from (
select sum(area_km2) total_area from project..data2)z) r on q.keyy=r.keyy)g

--window 

--output top 3 districts from each state with highest literacy rate


select a.* from
(select district,state,literacy,rank() over(partition by state order by literacy desc) rnk from project..data1) a

where a.rnk in (1,2,3) order by state



  
