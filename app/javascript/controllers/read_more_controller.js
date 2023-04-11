import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["shortText", "longText", "moreButton", "lessButton"];

    connect() {
        this.showLess();
    }

    showMore() {
        this.shortTextTarget.hidden = true;
        this.moreButtonTarget.hidden = true;
        this.longTextTarget.hidden = false;
        this.lessButtonTarget.hidden = false;
        console.log("show more");
    }

    showLess() {
        this.shortTextTarget.hidden = false;
        this.moreButtonTarget.hidden = false;
        this.longTextTarget.hidden = true;
        this.lessButtonTarget.hidden = true;
        console.log("show less");
    }
}
