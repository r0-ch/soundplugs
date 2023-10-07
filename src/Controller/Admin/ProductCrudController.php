<?php

namespace App\Controller\Admin;

use App\Entity\Product;
use EasyCorp\Bundle\EasyAdminBundle\Config\Crud;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\DateTimeField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\ChoiceField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ImageField;
use EasyCorp\Bundle\EasyAdminBundle\Field\MoneyField;
use Symfony\Component\Form\Extension\Core\Type\FileType;

class ProductCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Product::class;
    }

    public function configureCrud(Crud $crud): Crud
    {
        return $crud
            ->setEntityLabelInPlural('Produits')
            ->setEntityLabelInSingular('Produit')
            ->setPageTitle('index', 'SoundPlugs - Administration Produits')
            ->setPaginatorPageSize(10);
    }

    public function configureFields(string $pageName): iterable
    {
        return [
            IdField::new('id')
            ->setFormTypeOption('disabled', 'disabled'),
            TextField::new('title'),
            TextField::new('publisher'),
            MoneyField::new('price')->setCurrency('EUR'),
            ChoiceField::new('type')->setChoices([
                'Sample' => 'sample',
                'Plug-in' => 'plugin',
            ]),
            ChoiceField::new('category')->setChoices([
                'Effet' => 'effet',
                'Traitement' => 'traitement',
            ]),
            ChoiceField::new('genre')->setChoices([
                'Eléctronique' => 'electro',
                'Hip-hop' => 'hip-hop',
            ]),
            ImageField::new('image')
                ->setUploadDir('public/uploads/images')
                ->setUploadedFileNamePattern('/uploads/images/[slug]-[timestamp].[extension]'),
            TextField::new('file')
                ->setFormType(FileType::class)
                ->hideOnIndex(),
            TextEditorField::new('summary')
                ->hideOnIndex(),
            TextEditorField::new('description')
                ->hideOnIndex(),
            DateTimeField::new('createdAt')
                ->setFormTypeOption('disabled', 'disabled')
                ->hideOnIndex(),
            DateTimeField::new('updatedAt')
                ->hideOnIndex(),
        ];
    }
}
