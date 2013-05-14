Consolidator.Thing = DS.Model.extend({
    name: DS.attr("string"),
    createdAt: DS.attr("date"),
    updatedAt: DS.attr("date"),

    imageFileName: DS.attr("string"),
    imageContentType: DS.attr("string"),
    imageFileSize: DS.attr("number"),
    imageUpdatedAt: DS.attr("date"),
    imageRemoteURL: DS.attr("string"),

    heldBy: DS.belongsTo("Consolidator.User")
});
