{extends file='page.tpl'}

{block name="header"}
    <script src="{'js/vue.min.js'|resource}"></script>
    <script src="{'js/moment-with-locales.min.js'|resource}"></script>
{/block}

{block name=main}
    <script type="text/x-template" id="poll-finder-component">
        <div>
            <h3>
                {t('FindPolls', 'Polls saved inside this browser')}
                <a href="#" data-toggle="modal" data-target="#localstorage_help_modal">
                    <i class="fa fa-info-sign" aria-hidden="true"></i>
                </a><!-- TODO Add accessibility -->
            </h3>
            <div class="row" v-if="polls.length > 0 || adminPolls.length > 0">
                <div class="pull-right">
                    <button @click="removeAllPolls" class="btn btn-sm btn-danger">{t('FindPolls', "Remove all my polls from this browser's index")}</button>
                </div>
            </div>
            <div v-if="polls.length > 0">
                <h4>{t('FindPolls', 'Visited polls')}</h4>
                <div class="table-responsive">
                    <table class="table table-hover table-condensed">
                        <thead>
                        <tr>
                            <td>{t('FindPolls', 'Title')}</td>
                            <td>{t('FindPolls', 'Address')}</td>
                            <td>{t('FindPolls', 'Last access date')}</td>
                            <td>{t('FindPolls', 'Remove poll from index')}</td>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="poll in polls">
                            <td>%% poll.title %%</td>
                            <td><a :href="poll.url">%% poll.url %%</a></td>
                            <td>%% poll.accessed | date %%</td>
                            <td>
                                <button class="btn btn-sm btn-danger" @click="removePoll(poll.url)">
                                    <i class="fa fa-trash" aria-hidden="true"></i>
                                    <span class="sr-only">{t('Generic', 'Remove')}</span>
                                </button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div v-if="adminPolls.length > 0">
                <h4>{t('FindPolls', 'Created polls')}</h4>
                <div class="table-responsive">
                    <table class="table table-hover table-condensed">
                        <thead>
                        <tr>
                            <td>{t('FindPolls', 'Title')}</td>
                            <td>{t('FindPolls', 'Address')}</td>
                            <td>{t('FindPolls', 'Last access date')}</td>
                            <td>{t('FindPolls', 'Remove poll from index')}</td>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="poll in adminPolls">
                            <td>%% poll.title %%</td>
                            <td><a :href="poll.url">%% poll.url %%</a></td>
                            <td>%% poll.accessed | date %%</td>
                            <td>
                                <button class="btn btn-sm btn-danger" @click="removeAdminPoll(poll.url)">
                                    <i class="fa fa-trash" aria-hidden="true"></i>
                                    <span class="sr-only">{t('Generic', 'Remove')}</span>
                                </button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div v-if="polls.length === 0 && adminPolls.length === 0" class="alert alert-info">
                {t('FindPolls', 'There are no polls saved inside your browser yet')}
            </div>
        </div>
    </script>
    <div id="local-polls">
    </div>
    <div>
        <h3>{t('FindPolls', 'Send my polls by email')}</h3>
        {if !empty($message)}
            <div class="alert alert-dismissible alert-{$message->type|html}" role="alert">{$message->message|html}{if $message->link != null}<br/><a href="{$message->link}">{$message->link}</a>{/if}<button type="button" class="close" data-dismiss="alert" aria-label="{t('Generic', 'Close')}"><span aria-hidden="true">&times;</span></button></div>
        {/if}
        <form action="" method="post">
            <div class="row">
                <div class="col-md-6 col-md-offset-3 text-center">
                    <div class="form-group">
                        <div class="input-group">
                            <label for="mail" class="input-group-addon">{t('Generic', 'Your email address')}</label>
                            <input type="email" class="form-control" id="mail" name="mail" autofocus>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-md-offset-3 text-center">
                    <button type="submit" class="btn btn-success">{t('FindPolls', 'Send me my polls')}</button>
                </div>
            </div>
        </form>
    </div>
    <div id="localstorage_help_modal" class="modal fade">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">{t('FindPolls', 'Polls saved inside this browser')}</h4>
                </div>
                <div class="modal-body">
                    <div class="alert alert-info">
                        <p>{t('FindPolls', 'To help you find your previous polls, we save each poll you create or access inside your browser. This data is saved inside this browser only. The following data will be saved:')}</p>
                        <ul>
                            <li>{t('FindPolls', 'The title of the poll')}</li>
                            <li>{t('FindPolls', 'Its address')}</li>
                            <li>{t('FindPolls', 'The date you created or last accessed the poll')}</li>
                        </ul>
                        <p>{t('FindPolls', "To delete this data click the trashcan on the according line or click the « delete my polls index » option. This won't delete your polls.")}</p>
                    </div>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <script>
        moment.locale('{$locale}');

        var app = new Vue({
            delimiters: ['%%', '%%'],
            el: '#local-polls',
            template: '#poll-finder-component',
            data() {
                return {
                    polls: [],
                    adminPolls: [],
                };
            },
            created() {
                var polls = localStorage.getItem('polls');
                if (polls === null) {
                    this.polls = [];
                } else {
                    this.polls = JSON.parse(polls);
                }
                var adminPolls = localStorage.getItem('admin_polls');
                if (adminPolls === null) {
                    this.adminPolls = [];
                } else {
                    this.adminPolls = JSON.parse(adminPolls);
                }
            },
            filters: {
                date: function(value) {
                    return moment(value).format('LLLL');
                }
            },
            methods: {
                removePoll(pollKey) {
                    var index = this.polls.findIndex(function (existingPoll) {
                        return existingPoll.url === pollKey;
                    });
                    if (index === -1) {
                        console.error('Oh no, the poll doesn\'t exist !');
                    } else { // if the poll is already present, we need to update the last access date
                        this.polls.splice(index, 1);
                        localStorage.setItem('polls', JSON.stringify(this.polls));
                    }
                },
                removeAdminPoll(pollKey) {
                    var index = this.adminPolls.findIndex(function (existingPoll) {
                        return existingPoll.url === pollKey;
                    });
                    if (index === -1) {
                        console.error('Oh no, the admin poll doesn\'t exist !');
                    } else { // if the poll is already present, we need to update the last access date
                        this.adminPolls.splice(index, 1);
                        localStorage.setItem('admin_polls', JSON.stringify(this.adminPolls));
                    }
                },
                removeAllPolls() {
                    this.polls.splice(0, this.polls.length);
                    this.adminPolls.splice(0, this.adminPolls.length);
                    localStorage.setItem('admin_polls', JSON.stringify(this.adminPolls));
                    localStorage.setItem('polls', JSON.stringify(this.polls));
                }
            }
        });
    </script>
{/block}
