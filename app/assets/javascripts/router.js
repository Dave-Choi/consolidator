Consolidator.Router.map(function(){
    this.resource("users", function(){
        this.resource("user", { path: ":user_id" });
    });

    this.resource("things", function(){
        this.resource("thing", { path: ":thing_id" });
    });
});

Consolidator.ThingsRoute = Ember.Route.extend({
    model: function(){
        return Consolidator.Thing.find();
    }
});
