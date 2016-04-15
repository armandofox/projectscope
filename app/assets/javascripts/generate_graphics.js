var generateGraphics = function () {
    jQuery("tbody tr").each(function() {
       var projectID = jQuery(this).find(".projectID").text();
       var pullRequestGraphic = new PullRequestGraphic(projectID, jQuery(this).find("#"+projectID+"-pull-request-link").text());
       pullRequestGraphic.getPullRequestData();
       var slackGraphic = new SlackGraphic(projectID, jQuery(this).find("#"+projectID+"-slack-link").text());
       slackGraphic.getSlackData();
       var pivotalTrackerGraphic = new PivotalTrackerGraphic(projectID, jQuery(this).find('#'+projectID+"-pivotal-tracker-link").text());
       pivotalTrackerGraphic.getPivotalTrackerData();
    });
};
jQuery(generateGraphics);
