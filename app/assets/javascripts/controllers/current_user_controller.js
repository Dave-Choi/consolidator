Consolidator.currentUserController = Ember.ObjectController.create({
    getUser: function(){
        this.set("content", Consolidator.User.find("current"));
    }
});