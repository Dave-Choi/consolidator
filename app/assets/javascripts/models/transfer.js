Consolidator.Transfer = DS.Model.extend({
    thing: DS.belongsTo("Consolidator.Thing"),
    giver: DS.belongsTo("Consolidator.User"),
    receiver: DS.belongsTo("Consolidator.User")
});