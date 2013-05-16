Consolidator.Stake = DS.Model.extend({
    user: DS.belongsTo("Consolidator.User"),
    thing: DS.belongsTo("Consolidator.Thing"),

    amount: DS.attr("number")
});