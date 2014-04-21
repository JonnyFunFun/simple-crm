{extends '_template_.tpl'}

{block name=body}
    <h1>Customer List</h1>

    <table class="dataTable" cellspacing="0" cellpadding="0" border="0">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Type</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        {foreach item=customer from=$customers}
            <tr>
                <td><span class="badge">{$customer['customer_id']}</span></td>
                <td><a href="{$base_url}customers/{$customer['customer_id']}">{$customer['name']}</a></td>
                <td>{$customer['customer_type']}</td>
                <td>
                    <a href="{$base_url}customers/{$customer['customer_id']}"><button type="button" class="btn btn-sm btn-primary">View/Edit</button></a>
                    <a href="#" onclick="confirmPath('{$base_url}customers/delete/{$customer['customer_id']}');"><button type="button" class="btn btn-sm btn-danger">Delete</button></a>
                </td>
            </tr>
        {/foreach}
        </tbody>
    </table>
    <div class="clearfix"><br/><br/></div>
    <div class="well">
        <h5>Add a new customer:</h5>
        <form class="form-inline" role="form" action="{$base_url}customers/add/" method="POST">
            <div class="form-group">
                <label for="name">Customer name:</label>
                <input type="text" class="form-control" name="name" id="name" placeholder="Enter name">
            </div>
            <div class="form-group">
                <label for="customer_type_id">Customer type:</label>
                <select name="customer_type_id" id="customer_type_id">
                    <option disabled="disabled" selected="selected">-- Choose one --</option>
                {foreach item=type from=$customer_types}
                    <option value="{$type['customer_type_id']}">{$type['type_name']}</option>
                {/foreach}
                </select>
            </div>
            <button type="submit" class="btn btn-default">Add</button>
        </form>
    </div>
{/block}