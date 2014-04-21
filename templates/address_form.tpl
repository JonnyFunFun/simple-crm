<h2>Add a new address</h2>
<form role="form" action="{$base_url}addresses/customer_{$customer_id}/create" method="POST">
    <div class="form-group">
        <label for="address_type_id">Type</label>
        <select name="address_type_id" id="address_type_id">
            <option selected="selected" disabled="disabled">-- Select one --</option>
            {foreach item=type from=$address_types}
                <option value="{$type['address_type_id']}">{$type['type_name']}</option>
            {/foreach}
        </select>
    </div>
    <input type="hidden" name="customer_id" value="{$customer_id}"/>
    <div class="form-group">
        <label for="name">Name</label>
        <input type="text" class="form-control" id="name" placeholder="Enter name" name="name">
    </div>
    <div class="form-group">
        <label for="address_line_1">Address</label>
        <input type="text" class="form-control" id="address_line_1" placeholder="Address line 1" name="address_line_1">
        <input type="text" class="form-control" id="address_line_2" placeholder="Address line 2 (optional)" name="address_line_2">
    </div>
    <div class="form-group">
        <label for="city">City</label>
        <input type="text" class="form-control" id="city" placeholder="Enter city" name="city">
    </div>
    <div class="form-group">
        <label for="state">State/Province</label>
        <select name="state" id="state">
            <option selected="selected" disabled="disabled">-- Select one --</option>
            {foreach item=state from=$states}
                <option value="{$state['state_province_id']}">{$state['name']} ({$state['abbreviation']})</option>
            {/foreach}
        </select>
    </div>
    <div class="form-group">
        <label for="country">Country</label>
        <select name="country" id="country">
            <option selected="selected" disabled="disabled">-- Select one --</option>
            {foreach item=country from=$countries}
                <option value="{$country['country_id']}">{$country['name']} ({$country['abbreviation']})</option>
            {/foreach}
        </select>
    </div>

    <button type="submit" class="btn btn-default">Submit</button>
</form>