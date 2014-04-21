<h2>Add a new contact</h2>
<form role="form" action="{$base_url}contacts/customer_{$customer}/create" method="POST">
    <div class="form-group">
        <label for="title">Title</label>
        <input type="text" class="form-control" id="title" placeholder="Enter title" name="title">
    </div>
    <div class="form-group">
        <label for="contact_type_id">Type</label>
        <select name="contact_type_id" id="contact_type_id">
            <option selected="selected" disabled="disabled">-- Select one --</option>
            {foreach item=type from=$contact_types}
                <option value="{$type['contact_type_id']}">{$type['type_name']}</option>
            {/foreach}
        </select>
    </div>
    <div class="form-group">
        <label for="description">Description</label>
        <textarea style="width: 100%; height: 75%;" rows=8 name="description" id="description"></textarea>
    </div>
    <button type="submit" class="btn btn-default">Submit</button>
</form>