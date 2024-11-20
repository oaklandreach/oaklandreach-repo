public with sharing class DatabaseService {

    @AuraEnabled
    public static List<SObject> queryNow(String query, Map<String, String> filters){
        return query(query, filters);
    }

    @AuraEnabled(cacheable=true)
    public static List<SObject> query(String query, Map<String, String> filters){
        try {
            QueryBuilder queryBuilder = (QueryBuilder)JSON.deserialize(query, QueryBuilder.class);
            if (filters != null) queryBuilder.setFilterValues(filters);
            return Database.query(queryBuilder.toSOQL());
        } catch (Exception e) {
            throw TestManagerUtils.getAuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String queryAsJsonNow(String query, Map<String, String> filters){
        return JSON.serialize(query(query, filters));
    }

    @AuraEnabled(cacheable=true)
    public static List<AggregateResult> aggregateQuery(String query, Map<String, String> filters){
        try {
            QueryBuilder queryBuilder = (QueryBuilder)JSON.deserialize(query, QueryBuilder.class);
            if (filters != null)  queryBuilder.setFilterValues(filters);
            return Database.query(queryBuilder.toSOQL());
        } catch (Exception e) {
            throw TestManagerUtils.getAuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String aggregateQueryAsJsonNow(String query, Map<String, String> filters){
        return JSON.serialize(aggregateQuery(query, filters));
    }

}