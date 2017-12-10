using eBike.Data.Entities;
using eBike.Data.POCOs;
using eBikeSystem.DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBikeSystem.BLL
{
    [DataObject]
    public class PurchasingController
    {
        // Query to populate the drop down list with vendors to select
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<VendorListPOCO> VendorList()
        {
            using (var context = new eBikeContext())
            {
                var results = (from x in context.Vendors
                              select new VendorListPOCO
                              {
                                    VendorID = x.VendorID,
                                    VendorName = x.VendorName,
                                    City = x.City,
                                    Phone = x.Phone
                              }).OrderBy(z => z.VendorName);
                return results.ToList();
            }
        }

        // Query to show the vendor details for the selected vendor
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<VendorListPOCO> VendorDetails(int vendorid)
        {
            using (var context = new eBikeContext())
            {
                var results = (from x in context.Vendors
                               where x.VendorID == vendorid
                               select new VendorListPOCO
                               {
                                   VendorName = x.VendorName,
                                   City = x.City,
                                   Phone = x.Phone
                               }).OrderBy(z => z.VendorName);
                return results.ToList();
            }
        }

        // Query to find the current active purchase order for the vendor
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PurchaseOrderPartsPOCO> ActivePurchaseOrder_ByVendor(int vendorid)
        {
            using (var context = new eBikeContext())
            {
                var activeorder = (from x in context.PurchaseOrders
                                   where x.VendorID == vendorid && x.PurchaseOrderNumber == null && x.OrderDate == null
                                   select x.PurchaseOrderID).FirstOrDefault();

                var purchaseorderdetailid = (from x in context.PurchaseOrderDetails
                                             where x.PurchaseOrder.VendorID == vendorid && x.PurchaseOrder.PurchaseOrderNumber == null && x.PurchaseOrder.OrderDate == null
                                             select x.PurchaseOrderDetailID).FirstOrDefault();

                var results = (from x in context.PurchaseOrderDetails
                               where x.PurchaseOrderID == activeorder
                               select new PurchaseOrderPartsPOCO
                              {
                                  PurchaseOrderID = x.PurchaseOrderID,
                                  PurchaseOrderDetailID = purchaseorderdetailid,
                                  PartID = x.PartID,
                                  Description = x.Part.Description,
                                  QuantityOnHand = x.Part.QuantityOnHand,
                                  QuantityOnOrder = x.Part.QuantityOnOrder,
                                  ReorderLevel = x.Part.ReorderLevel,
                                  Quantity = x.Quantity,
                                  PurchasePrice = x.PurchasePrice
                              }).OrderBy(z => z.PartID);
                return results.ToList();
            }
        }

        // Query to display the current inventory not on the vendor purchase order
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PurchaseOrderPartsPOCO> PartsInventory_ByVendor(int vendorid)
        {
            using (var context = new eBikeContext())
            {
                var activeorder = (from x in context.PurchaseOrders
                                   where x.VendorID == vendorid && x.PurchaseOrderNumber == null && x.OrderDate == null
                                   select x.PurchaseOrderID).FirstOrDefault();

                var activeorderparts = from x in context.PurchaseOrderDetails
                                       where x.PurchaseOrderID == activeorder
                                       select x.PartID;

                var results = (from x in context.Parts
                               where x.VendorID == vendorid && !activeorderparts.Contains(x.PartID)
                               select new PurchaseOrderPartsPOCO
                               {
                                   PartID = x.PartID,
                                   Description = x.Description,
                                   QuantityOnHand = x.QuantityOnHand,
                                   QuantityOnOrder = x.QuantityOnOrder,
                                   ReorderLevel = x.ReorderLevel,
                                   Buffer = x.ReorderLevel - (x.QuantityOnHand + x.QuantityOnOrder),
                                   PurchasePrice = x.PurchasePrice
                               }).OrderBy(z => z.PartID);
                return results.ToList();
            }
        }

        public void UpdateTotalsSuggestedOrder(PurchaseOrder purchaseorder, PurchaseOrder purchaseordertotals)
        {
            using (var context = new eBikeContext()) // start transaction
            {
                var activeorder = (from x in context.PurchaseOrders
                                   where x.VendorID == purchaseorder.VendorID && x.PurchaseOrderNumber == null && x.OrderDate == null
                                   select x.PurchaseOrderID).FirstOrDefault();

                var updateSubtotal = context.PurchaseOrders.Find(activeorder);
                updateSubtotal.SubTotal = purchaseordertotals.SubTotal;

                context.Entry(updateSubtotal).Property(y => y.SubTotal).IsModified = true;

                var updateTaxAmount = context.PurchaseOrders.Find(activeorder);
                updateTaxAmount.TaxAmount = purchaseordertotals.TaxAmount;

                context.Entry(updateTaxAmount).Property(y => y.TaxAmount).IsModified = true;

                // save the changes to database and end transaction
                context.SaveChanges();
            }
        }

        // this is to create the suggested order in the database
        public void NewSuggestedOrder(PurchaseOrder purchaseorder, List<PurchaseOrderDetail> purchaseorderdetails)
        {
            using (var context = new eBikeContext()) // start transaction
            {
                // MUST CHANGE THIS TO REFLECT CURRENT LOGGED IN EMPLOYEE //
                purchaseorder.EmployeeID = 1;
                ////////////////////////////////////////////////////////////

                // add the created suggested purchase order to the database
                purchaseorder = context.PurchaseOrders.Add(purchaseorder);    //staging

                // add the created suggested purchase order details to the database
                foreach (PurchaseOrderDetail detail in purchaseorderdetails)
                {
                    detail.PurchaseOrderID = purchaseorder.PurchaseOrderID;
                    context.PurchaseOrderDetails.Add(detail);
                }

                // save the changes to database and end transaction
                context.SaveChanges();
            }
        }

        public void PurchaseOrder_Delete(int purchaseOrderID)
        {
            using (var context = new eBikeContext())
            {

                context.PurchaseOrderDetails.RemoveRange(context.PurchaseOrderDetails.Where(x => x.PurchaseOrderID == purchaseOrderID));

                context.SaveChanges();

                var existingorderid = context.PurchaseOrders.Find(purchaseOrderID);
                context.PurchaseOrders.Remove(existingorderid);

                context.SaveChanges();

            }
        }

        public void Update_PurchaseOrder(PurchaseOrder purchaseorder, List<PurchaseOrderDetail> purchaseorderdetails)
        {
            using (var context = new eBikeContext())
            {

                var activeorder = (from x in context.PurchaseOrderDetails
                                   where x.PurchaseOrder.VendorID == purchaseorder.VendorID && x.PurchaseOrder.PurchaseOrderNumber == null && x.PurchaseOrder.OrderDate == null
                                   select x.PurchaseOrderID).FirstOrDefault();

                var purchaseorderdetailID = (from x in purchaseorderdetails
                                            where x.PurchaseOrderID == activeorder
                                            select x.PurchaseOrderDetailID).ToList();

                List<PurchaseOrderPartsPOCO> existing = (from x in context.PurchaseOrderDetails
                                                    where x.PurchaseOrderID == activeorder
                                                    select new PurchaseOrderPartsPOCO
                                                    {
                                                        PartID = x.PartID,
                                                        Description = x.Part.Description,
                                                        QuantityOnHand = x.Part.QuantityOnHand,
                                                        QuantityOnOrder = x.Part.ReorderLevel,
                                                        ReorderLevel = x.Part.QuantityOnOrder,
                                                        Quantity = x.Quantity,
                                                        PurchasePrice = x.PurchasePrice
                                                    }).ToList();

                var updatedata = purchaseorderdetails.Where(x => existing.Any(y => y.PartID == x.PartID));

                foreach (var functionupdate in updatedata)
                {
                    int detailid = (from x in context.PurchaseOrderDetails
                              where x.PurchaseOrderID == activeorder && x.PartID == functionupdate.PartID
                              select x.PurchaseOrderDetailID).Single();

                    PurchaseOrderDetail update = context.PurchaseOrderDetails.Find(detailid);

                    update.PurchasePrice = functionupdate.PurchasePrice;
                    update.Quantity = functionupdate.Quantity;

                    var newlyadded = context.PurchaseOrderDetails.Attach(update);
                    var updated = context.Entry(newlyadded);

                    updated.State = EntityState.Modified;
                }

                // save the changes to database and end transaction
                context.SaveChanges();
            }
        }

        // query to find parts for and display the suggested order 
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PurchaseOrderPartsPOCO> SuggestedPurchaseOrder_ByVendor(int vendorid)
        {
            using (var context = new eBikeContext())
            {
                var purchaseorderid = (from x in context.PurchaseOrders
                                   where x.VendorID == vendorid && x.PurchaseOrderNumber == null && x.OrderDate == null
                                   select x.PurchaseOrderID).FirstOrDefault();

                var purchaseorderdetailid = (from x in context.PurchaseOrderDetails
                                       where x.PurchaseOrder.VendorID == vendorid && x.PurchaseOrder.PurchaseOrderNumber == null && x.PurchaseOrder.OrderDate == null
                                       select x.PurchaseOrderDetailID).FirstOrDefault();

                var results = (from x in context.Parts
                               where x.VendorID == vendorid && x.ReorderLevel - (x.QuantityOnHand + x.QuantityOnOrder) > 0
                               select new PurchaseOrderPartsPOCO
                               {
                                   PurchaseOrderID = purchaseorderid,
                                   PurchaseOrderDetailID = purchaseorderdetailid,
                                   PartID = x.PartID,
                                   Description = x.Description,
                                   QuantityOnHand = x.QuantityOnHand,
                                   QuantityOnOrder = x.QuantityOnOrder,
                                   ReorderLevel = x.ReorderLevel,
                                   Quantity = x.ReorderLevel - (x.QuantityOnHand + x.QuantityOnOrder),
                                   PurchasePrice = x.PurchasePrice
                               }).OrderBy(z => z.PartID);
                return results.ToList();
            }
        }

        // query to find the subtotal, tax and total of the current purchase order 
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public PurchaseOrderTotalsPOCO PurchaseOrderTotals(int vendorid)
        {
            using (var context = new eBikeContext())
            {
                var ordertotals = new PurchaseOrderTotalsPOCO();

                var otherresults = (from x in context.PurchaseOrderDetails
                               where x.PurchaseOrder.VendorID == vendorid && x.PurchaseOrder.PurchaseOrderNumber == null && x.PurchaseOrder.OrderDate == null
                               select x).FirstOrDefault();

                if (otherresults == null)
                {
                    ordertotals.SubTotal = 0;
                    ordertotals.TaxAmount = 0;
                    ordertotals.Total = 0;
                }
                else
                {

                    var results = (from x in context.PurchaseOrderDetails
                                   where x.PurchaseOrder.VendorID == vendorid && x.PurchaseOrder.PurchaseOrderNumber == null && x.PurchaseOrder.OrderDate == null
                                   select (x.Quantity * x.Part.PurchasePrice)).Sum();

                    ordertotals.SubTotal = results;
                    ordertotals.TaxAmount = Decimal.Multiply(results, 0.05m);
                    ordertotals.Total = ordertotals.SubTotal + ordertotals.TaxAmount;
                }
                return ordertotals;
            }
        }
    }
}
