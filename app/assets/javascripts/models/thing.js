Consolidator.Thing = DS.Model.extend({
    name: DS.attr("string"),
    createdAt: DS.attr("date"),
    updatedAt: DS.attr("date"),
    image: DS.attr("string"),

    holder: DS.belongsTo("Consolidator.User"),
    owners: DS.hasMany("Consolidator.User")
});
