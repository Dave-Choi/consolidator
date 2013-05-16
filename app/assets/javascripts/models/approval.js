Consolidator.Approval = DS.Model.extend({
    borrowRequest: DS.belongsTo("Consolidator.BorrowRequest"),
    user: DS.belongsTo("Consolidator.User"),

    status: DS.attr("string"),

    // Really hasOne relationships
    thing: DS.belongsTo("Consolidator.Thing"),
    borrower: DS.belongsTo("Consolidator.User")
});