{$admin = $admin|default:false}

{if $admin}<form action="{poll_url id=$admin_poll_id admin=true}" method="POST">{/if}
    <div class="jumbotron{if $admin} bg-danger{/if}">
        <div class="row"> {* Title | buttons*}
            <div id="title-form" class="col-md-7">
                <h3>
                    {$poll->title|html}{if $admin && !$expired}
                    <button class="btn btn-link btn-sm btn-edit" title="{t('PollInfo', 'Edit title')}">
                        <i class="fa fa-pencil" aria-hidden="true"></i>
                        <span class="sr-only">{t('Generic', 'Edit')}</span>
                    </button>
                    {/if}
                </h3>
                {if $admin && !$expired}
                    <div class="hidden js-title">
                        <label class="sr-only" for="newtitle">{t('PollInfo', 'Title of the poll')}</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="newtitle" name="title" size="40" value="{$poll->title|html}" />
                            <span class="input-group-btn">
                                <button type="submit" class="btn btn-success" name="update_poll_info" value="title" title="{t('PollInfo', 'Save the new title')}">
                                    <i class="fa fa-check" aria-hidden="true"></i>
                                    <span class="sr-only">{t('Generic', 'Save')}</span>
                                </button>
                                <button class="btn btn-link btn-cancel" title="{t('PollInfo', 'Cancel the title edit')}">
                                    <i class="fa fa-remove" aria-hidden="true"></i>
                                    <span class="sr-only">{t('Generic', 'Cancel')}</span>
                                </button>
                            </span>
                        </div>
                    </div>
                {/if}
            </div>
            <div class="col-md-5 hidden-print">
                <div class="btn-group pull-right">
                    <button onclick="print(); return false;" class="btn btn-default">
                        <i class="fa fa-print" aria-hidden="true"></i> {t('PollInfo', 'Print')}
                    </button>
                    {if $admin}
                        <a href="{$SERVER_URL|html}exportcsv.php?admin={$admin_poll_id|html}" class="btn btn-default">
                            <i class="fa fa-download" aria-hidden="true"></i> {t('PollInfo', 'Export to CSV')}
                        </a>
                    {else}
                        {if !$hidden}
                            <a href="{$SERVER_URL|html}exportcsv.php?poll={$poll_id|html}" class="btn btn-default">
                                <i class="fa fa-download"></i> {t('PollInfo', 'Export to CSV')}
                            </a>
                        {/if}
                    {/if}
                    {if $admin}
                        {if !$expired}
                        <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown">
                            <i class="fa fa-trash" aria-hidden="true"></i>
                            <span class="sr-only">{t('Generic', 'Remove')}</span>
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <li><button class="btn btn-link" type="submit" name="remove_all_votes">{t('PollInfo', 'Remove all votes') }</button></li>
                            <li><button class="btn btn-link" type="submit" name="remove_all_comments">{t('PollInfo', 'Remove all comments')}</button></li>
                            <li class="divider" role="presentation"></li>
                            <li><button class="btn btn-link" type="submit" name="delete_poll">{t('PollInfo', 'Remove the poll')}</button></li>
                        </ul>
                        {else}
                            <button class="btn btn-danger" type="submit" name="delete_poll" title="{t('PollInfo', 'Remove the poll')}">
                                <i class="fa fa-trash" aria-hidden="true"></span>
                                <span class="sr-only">{t('PollInfo', 'Remove the poll')}</span>
                            </button>
                        {/if}
                    {/if}
                </div>
            </div>
        </div>
        <div class="row"> {* Admin name + email | Description *}
            <div class="form-group col-md-4">
                <div id="name-form">
                    <label class="control-label">{t('PollInfo', 'Creator of the poll')}</label>
                    <p class="form-control-static">
                        {$poll->admin_name|html}{if $admin && !$expired}
                        <button class="btn btn-link btn-sm btn-edit" title="{t('PollInfo', 'Edit name')}">
                            <i class="fa fa-pencil" aria-hidden="true"></i>
                            <span class="sr-only">{t('Generic', 'Edit')}</span>
                        </button>
                        {/if}
                    </p>
                    {if $admin && !$expired}
                    <div class="hidden js-name">
                        <label class="sr-only" for="newname">{t('PollInfo', 'Creator of the poll')}</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="newname" name="name" size="40" value="{$poll->admin_name|html}" />
                            <span class="input-group-btn">
                                <button type="submit" class="btn btn-success" name="update_poll_info" value="name" title="{t('PollInfo', 'Save the new name')}">
                                    <i class="fa fa-check" aria-hidden="true"></i>
                                    <span class="sr-only">{t('Generic', 'Save')}</span>
                                </button>
                                <button class="btn btn-link btn-cancel" title="{t('PollInfo', 'Cancel the name edit')}">
                                    <i class="fa fa-remove" aria-hidden="true"></i>
                                    <span class="sr-only">{t('Generic', 'Cancel')}</span>
                                </button>
                            </span>
                        </div>
                    </div>
                    {/if}
                </div>
                {if $admin}
                <div id="email-form">
                    <p>
                        {$poll->admin_mail|html}{if !$expired}
                        <button class="btn btn-link btn-sm btn-edit" title="{t('PollInfo', 'Edit the email address')}">
                            <i class="fa fa-pencil" aria-hidden="true"></i>
                            <span class="sr-only">{t('Generic', 'Edit')}</span>
                        </button>
                        {/if}
                    </p>
                    {if !$expired}
                        <div class="hidden js-email">
                            <label class="sr-only" for="admin_mail">{t('PollInfo', 'Email')}</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="admin_mail" name="admin_mail" size="40" value="{$poll->admin_mail|html}" />
                            <span class="input-group-btn">
                                <button type="submit" name="update_poll_info" value="admin_mail" class="btn btn-success" title="{t('PollInfo', 'Save the email address')}">
                                    <i class="fa fa-check" aria-hidden="true"></i>
                                    <span class="sr-only">{t('Generic', 'Save')}</span>
                                </button>
                                <button class="btn btn-link btn-cancel" title="{t('PollInfo', 'Cancel the email address edit')}">
                                    <i class="fa fa-remove" aria-hidden="true"></i>
                                    <span class="sr-only">{t('Generic', 'Cancel')}</span>
                                </button>
                            </span>
                            </div>
                        </div>
                    {/if}
                </div>
                {/if}
            </div>
            {if $admin || preg_match('/[^ \r\n]/', $poll->description)}
                <div class="form-group col-md-8" id="description-form">
                    <label class="control-label">
                        {t('Generic', 'Description')}
                        {if $admin && !$expired}
                        <button class="btn btn-link btn-sm btn-edit" title="{t('PollInfo', 'Edit the description')}">
                            <i class="fa fa-pencil" aria-hidden="true"></i>
                            <span class="sr-only">{t('Generic', 'Edit')}</span>
                        </button>
                        {/if}
                    </label>
                    <div class="form-control-static well poll-description">{$poll->description|markdown:false:false}</div>
                    {if $admin && !$expired}
                        <div class="hidden js-desc">
                            <label class="sr-only" for="newdescription">{t('Generic', 'Description')}</label>
                            {include 'part/description_markdown.tpl'}
                            <textarea class="form-control" id="newdescription" name="description" rows="2" cols="40">{$poll->description|html}</textarea>
                            <button type="submit" id="btn-new-desc" name="update_poll_info" value="description" class="btn btn-sm btn-success" title="{t('PollInfo', 'Save the description')}">
                                <i class="fa fa-check" aria-hidden="true"></i>
                                <span class="sr-only">{t('Generic', 'Save')}</span>
                            </button>
                            <button class="btn btn-default btn-sm btn-cancel" title="{t('PollInfo', 'Cancel the description edit')}">
                                <i class="fa fa-remove" aria-hidden="true"></i>
                                <span class="sr-only">{t('Generic', 'Cancel')}</span>
                            </button>
                        </div>
                    {/if}
                </div>
            {/if}
        </div>
        <div class="row">
        </div>

        <div class="row">
            <div class="form-group form-group {if $admin}col-md-4{else}col-md-6{/if}">
                <label for="public-link">
                    <a class="public-link" href="{poll_url id=$poll_id}">
                        {t('PollInfo', 'Public link to the poll')}
                        <i class="btn-link fa fa-link" aria-hidden="true"></i>
                    </a>
                </label>
                <input class="form-control" id="public-link" type="text" readonly="readonly" value="{poll_url id=$poll_id}" onclick="select();"/>
            </div>
            {if $admin}
                <div class="form-group col-md-4">
                    <label for="admin-link">
                        <a class="admin-link" href="{poll_url id=$admin_poll_id admin=true}">
                            {t('PollInfo', 'Admin link for the poll')}
                            <i class="btn-link fa fa-link" aria-hidden="true"></i>
                        </a>
                    </label>
                    <input class="form-control" id="admin-link" type="text" readonly="readonly" value="{poll_url id=$admin_poll_id admin=true}" onclick="select();"/>
                </div>
                <div id="expiration-form" class="form-group col-md-4">
                    <label class="control-label">{t('Generic', 'Expiry date')}</label>
                    <p>{$poll->end_date|date_format_intl:DATE_FORMAT_FULL|html}
                        <button class="btn btn-link btn-sm btn-edit" title="{t('PollInfo', 'Edit the expiry date')}">
                            <i class="fa fa-pencil" aria-hidden="true"></i>
                            <span class="sr-only">{t('Generic', 'Edit')}</span>
                        </button>
                    </p>

                        <div class="hidden js-expiration">
                            <label class="sr-only" for="newexpirationdate">{t('Generic', 'Expiry date')}</label>
                            <div class="input-group">
                                <input type="text"
                                       class="form-control"
                                       id="newexpirationdate"
                                       name="expiration_date"
                                       size="40"
                                       value="{$poll->end_date|date_format_translation|html}"
                                />
                                <span class="input-group-btn">
                                    <button type="submit"
                                            class="btn btn-success"
                                            name="update_poll_info"
                                            value="expiration_date"
                                            title="{t('PollInfo', 'Save the new expiration date')}"
                                    >
                                        <i class="fa fa-check" aria-hidden="true"></i>
                                        <span class="sr-only">{t('Generic', 'Save')}</span>
                                    </button>
                                    <button class="btn btn-link btn-cancel"
                                            title="{t('PollInfo', 'Cancel the expiration date edit')}">
                                        <i class="fa fa-remove" aria-hidden="true"></i>
                                        <span class="sr-only">{t('Generic', 'Cancel')}</span>
                                    </button>
                                </span>
                            </div>
                        </div>

                </div>
            {/if}
        </div>
        {if $admin}
            <div class="row">
                <div class="col-md-4">
                    <div id="password-form">
                        {if !empty($poll->password_hash) && !$poll->results_publicly_visible}
                            {$password_text = t('PollInfo', 'Password protected')}
                        {elseif !empty($poll->password_hash) && $poll->results_publicly_visible}
                            {$password_text = t('PollInfo', 'Votes protected by password')}
                        {else}
                            {$password_text = t('PollInfo', 'No password')}
                        {/if}
                        <p>
                            <i class="fa fa-lock" aria-hidden="true"></i> {$password_text}
                            <button class="btn btn-link btn-sm btn-edit" title="{t('PollInfo', 'Edit the poll rules')}">
                                <i class="fa fa-pencil" aria-hidden="true"></i>
                                <span class="sr-only">{t('Generic', 'Edit')}</span>
                            </button>
                        </p>
                        <div class="hidden js-password">
                            <button class="btn btn-link btn-cancel" title="{t('PollInfo', 'Cancel the rules edit')}">
                                <i class="fa fa-remove" aria-hidden="true"></i>
                                <span class="sr-only">{t('Generic', 'Cancel')}</span>
                            </button>
                            {if !empty($poll->password_hash)}
                                <div class="input-group">
                                    <input type="checkbox" id="removePassword" name="removePassword"/>
                                    <label for="removePassword">{t('PollInfo', 'Remove password')}</label>
                                    <button type="submit" name="update_poll_info" value="removePassword" class="btn btn-success hidden" title="{t('PollInfo', 'Save the new rules')}">
                                        <i class="fa fa-check" aria-hidden="true"></i>
                                        <span class="sr-only">{t('Generic', 'Remove password.')}</span>
                                    </button>
                                </div>
                            {/if}
                            <div id="password_information">
                                <div class="input-group">
                                    <input type="checkbox" id="resultsPubliclyVisible" name="resultsPubliclyVisible" {if $poll->results_publicly_visible && $poll->hidden == false && (!empty($poll->password_hash))}checked="checked" {elseif ($poll->hidden == true || empty($poll->password_hash))} disabled="disabled"{/if}/>
                                    <label for="resultsPubliclyVisible">{t('PollInfo', 'Only votes are protected')}</label>
                                </div>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="password" name="password"/>
                                    <span class="input-group-btn">
                                        <button type="submit" name="update_poll_info" value="password" class="btn btn-success" title="{t('PollInfo', 'Save the new rules')}">
                                            <i class="fa fa-check" aria-hidden="true"></i>
                                            <span class="sr-only">{t('Generic', 'Save')}</span>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 ">
                    <div id="poll-hidden-form">
                        {if $poll->hidden}
                            {$hidden_icon = "fa-eye-slash"}
                            {$hidden_text = t('PollInfo', 'Results are hidden')}
                        {else}
                            {$hidden_icon = "fa-eye"}
                            {$hidden_text = t('PollInfo', 'Results are visible')}
                        {/if}
                        <p>
                            <i class="fa {$hidden_icon}" aria-hidden="true"></i> {$hidden_text}
                            <button class="btn btn-link btn-sm btn-edit" title="{t('PollInfo', 'Edit the poll rules')}">
                                <i class="fa fa-pencil" aria-hidden="true"></i>
                                <span class="sr-only">{t('Generic', 'Edit')}</span>
                            </button>
                        </p>
                        <div class="hidden js-poll-hidden">
                            <div class="input-group">
                                <input type="checkbox" id="hidden" name="hidden" {if $poll->hidden}checked="checked"{/if}/>
                                <label for="hidden">{t('PollInfo', 'Results are hidden')}</label>
                                <span class="input-group-btn">
                                    <button type="submit" name="update_poll_info" value="hidden" class="btn btn-success" title="{t('PollInfo', 'Save the new rules')}">
                                        <i class="fa fa-check" aria-hidden="true"></i>
                                        <span class="sr-only">{t('Generic', 'Save')}</span>
                                    </button>
                                    <button class="btn btn-link btn-cancel" title="{t('PollInfo', 'Cancel the rules edit')}">
                                        <i class="fa fa-remove" aria-hidden="true"></i>
                                        <span class="sr-only">{t('Generic', 'Cancel')}</span>
                                    </button>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4" >
                    <div id="poll-rules-form">
                        {if $poll->active}
                            {if $poll->editable}
                                {if $poll->editable == constant("Framadate\Editable::EDITABLE_BY_ALL")}
                                    {$rule_id = 2}
                                    {$rule_txt = t('Step 1', 'All voters can modify any vote')}
                                {else}
                                    {$rule_id = 3}
                                    {$rule_txt = t('Step 1', 'Voters can modify their own vote themselves')}
                                {/if}
                                {$rule_icon = '<i class="fa fa-edit" aria-hidden="true"></i>'}
                            {else}
                                {$rule_id = 1}
                                {$rule_icon = '<i class="fa fa-check-square-o" aria-hidden="true"></i>'}
                                {$rule_txt = t('Step 1', 'Votes cannot be modified')}
                            {/if}
                        {else}
                            {$rule_id = 0}
                            {$rule_icon = '<i class="fa fa-lock" aria-hidden="true"></i>'}
                            {$rule_txt = t('PollInfo', 'Votes and comments are locked')}
                        {/if}
                        <p>{$rule_icon} {$rule_txt|html}
                            <button class="btn btn-link btn-sm btn-edit" title="{t('PollInfo', 'Edit the poll rules')}">
                                <i class="fa fa-pencil" aria-hidden="true"></i>
                                <span class="sr-only">{t('Generic', 'Edit')}</span>
                            </button>
                        </p>
                        <div class="hidden js-poll-rules">
                            <label class="sr-only" for="rules">{t('PollInfo', 'Poll rules')}</label>
                            <div class="input-group">
                                <select class="form-control" id="rules" name="rules">
                                    <option value="0"{if $rule_id==0} selected="selected"{/if}>{t('PollInfo', 'Votes and comments are locked')}</option>
                                    <option value="1"{if $rule_id==1} selected="selected"{/if}>{t('Step 1', 'Votes cannot be modified')}</option>
                                    <option value="3"{if $rule_id==3} selected="selected"{/if}>{t('Step 1', 'Voters can modify their own vote themselves')}</option>
                                    <option value="2"{if $rule_id==2} selected="selected"{/if}>{t('Step 1', 'All voters can modify any vote')}</option>
                                </select>
                                <span class="input-group-btn">
                                    <button type="submit" name="update_poll_info" value="rules" class="btn btn-success" title="{t('PollInfo', 'Save the new rules')}">
                                        <i class="fa fa-check" aria-hidden="true"></i>
                                        <span class="sr-only">{t('Generic', 'Save')}</span>
                                    </button>
                                    <button class="btn btn-link btn-cancel" title="{t('PollInfo', 'Cancel the rules edit')}">
                                        <i class="fa fa-remove" aria-hidden="true"></i>
                                        <span class="sr-only">{t('Generic', 'Cancel')}</span>
                                    </button>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="collect_users_mail">
            {if $poll->collect_users_mail == constant("Framadate\CollectMail::NO_COLLECT")}
                {$txt=t('PollInfo', "Voters' email addresses are not collected")}
            {else if $poll->collect_users_mail == constant("Framadate\CollectMail::COLLECT")}
                {$txt=t('PollInfo', "Voters' email addresses are collected")}
            {else if $poll->collect_users_mail == constant("Framadate\CollectMail::COLLECT_REQUIRED")}
                {$txt=t('PollInfo', "Voters' email addresses are collected and required")}
            {else if $poll->collect_users_mail == constant("Framadate\CollectMail::COLLECT_REQUIRED_VERIFIED")}
                {$txt=t('PollInfo', "Voters' email addresses are collected, required and verified")}
            {else}
                {$txt='Error'}
            {/if}
                <p><i class="fa fa-envelope" aria-hidden="true"></i> {$txt|html}</p>

            </div>
        {/if}
    </div>
{if $admin}</form>{/if}
