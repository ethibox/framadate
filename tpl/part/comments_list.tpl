<div id="comments_list">
    <form action="{if $admin}{poll_url id=$admin_poll_id admin=true}{else}{poll_url id=$poll_id}{/if}" method="POST">
    {if $comments|count > 0}
        <h3>{t('Comments', 'Comments')}</h3>
        {foreach $comments as $comment}
            <div class="comment">
                {if $admin && !$expired}
                    <button type="submit" name="delete_comment" value="{$comment->id|html}" class="btn btn-link" title="{t('Comments', 'Remove comment')}">
                        <i class="fa fa-trash text-danger"></i>
                        <span class="sr-only">{t('Generic', 'Remove')}</span>
                    </button>
                {/if}
{*                <span>{$comment->date}</span>*}
{*                <span>{$comment->date|date_format_intl}</span>*}
                <span class="comment_date">{$comment->date|date_format_intl:DATE_FORMAT_SHORT}</span>
                <b>{$comment->name|html}</b>&nbsp;
                <span>{$comment->comment|escape|nl2br}</span>
            </div>
        {/foreach}
    {/if}
    </form>
    <div id="comments_alerts"></div>
</div>
