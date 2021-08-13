{% docs demand_module_sales %}
 This Model takes all the sales that is happening in raw format. Later taking away the frieght rows.
 This is mainly used to feed the Demand Module forcasting algo.
 The specification has been ordered by Egmont IT Data science team.
 Removes are defined in the main project in the dbt_project. The variable {removes} are only available in the demand_module package and resources. 
{% enddocs %}