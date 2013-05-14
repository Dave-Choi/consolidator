Consolidator.User = DS.Model.extend({
    email: DS.attr("string"),
    name: DS.attr("string"),
    createdAt: DS.attr("date"),
    updatedAt: DS.attr("date")
});
