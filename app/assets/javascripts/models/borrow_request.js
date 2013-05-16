Consolidator.BorrowRequest = DS.Model.extend({
    createdAt: DS.attr("date"),
    updatedAt: DS.attr("date"),

    thing: DS.belongsTo("Consolidator.Thing"),
    user: DS.belongsTo("COnsolidator.User"),

    approvals: DS.hasMany("Consolidator.Approval"),
    // Really hasOne
    transfer: DS.belongsTo("Consolidator.Transfer")
});