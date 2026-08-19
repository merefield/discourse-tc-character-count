import Component from "@glimmer/component";

export default class CharacterCountComponent extends Component {
  get showRequired() {
    return this.args.missingReplyCharacters > 0;
  }

  get charCount() {
    return this.showRequired
      ? `${this.args.length} / ${this.args.minimumLength}`
      : settings.character_count_hide_count_when_sufficient
        ? ""
        : `${this.args.length}`;
  }

  <template>
    {{#if this.charCount}}
      <div
        class="character-counts {{if this.showRequired 'more-required'}}"
        ...attributes
      >
        {{this.charCount}}
      </div>
    {{/if}}
  </template>
}
