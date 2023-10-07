<?php

namespace App\Controller\Admin;

use App\Entity\Order;
use App\Controller\Admin\ProductCrudController;
use App\Repository\ProductRepository;
use Doctrine\ORM\EntityManager;
use EasyCorp\Bundle\EasyAdminBundle\Config\Crud;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\DateField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ArrayField;
use EasyCorp\Bundle\EasyAdminBundle\Field\MoneyField;
use EasyCorp\Bundle\EasyAdminBundle\Field\CollectionField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;

class OrderCrudController extends AbstractCrudController
{
    private ProductRepository $productRepository;

    public static function getEntityFqcn(): string
    {
        return Order::class;
    }

    public function configureCrud(Crud $crud): Crud
    {
        return $crud
            ->setEntityLabelInPlural('Commandes')
            ->setEntityLabelInSingular('Commande')
            ->setPageTitle('index', 'SoundPlugs - Administration Commandes')
            ->setPaginatorPageSize(10);
    }

    public function configureFields(string $pageName): iterable
    {

        return [
            IdField::new('id')
                ->setFormTypeOption('disabled', 'disabled'),
            DateField::new('createdAt')
                ->setFormTypeOption('disabled', 'disabled'),
            TextField::new('reference')
                ->setFormTypeOption('disabled', 'disabled'),
            // AssociationField::new('customer')
            //     ->hideOnIndex(),
            MoneyField::new('price')
                ->setCurrency('EUR')
                ->hideOnIndex(),
            AssociationField::new('products')

        ];
    }
}
