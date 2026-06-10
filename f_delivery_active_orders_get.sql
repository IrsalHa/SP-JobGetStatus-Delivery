CREATE OR REPLACE FUNCTION public.f_delivery_active_orders_get()
RETURNS TABLE (
    awb_no varchar,
    courier_code varchar,
    invoice_id varchar,
    group_order_id varchar,
    order_id varchar
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        d.awb_no,
        d.courier_code,
        d.invoice_id,
        d.group_order_id,
        d.order_id
    FROM public.t_delivery_he d
    WHERE (d.status_desc IS NULL OR d.status_desc <> 'Pesanan Selesai')
      AND (
           d.status_code IS NULL
        OR d.status_code IN (
            'waiting_for_confirmation',
            'process',
            'ready_to_pickup',
            'on_delivery'
        )
      );
END;
$$ LANGUAGE plpgsql STABLE;
