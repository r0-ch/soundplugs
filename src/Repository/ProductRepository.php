<?php

namespace App\Repository;

use App\Entity\Product;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Tools\Pagination\Paginator;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Product>
 *
 * @method Product|null find($id, $lockMode = null, $lockVersion = null)
 * @method Product|null findOneBy(array $criteria, array $orderBy = null)
 * @method Product[]    findAll()
 * @method Product[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProductRepository extends ServiceEntityRepository {
    public function __construct(ManagerRegistry $registry) {
        parent::__construct($registry, Product::class);
    }

    public function findByCategory(string $category, int $page, int $limit): array {
        $limit = abs($limit);
        $result = [];

        $query = $this->findByCategoryQueryBuilder($category)
            ->setMaxResults($limit)
            ->setFirstResult(($page * $limit) - $limit);

        $paginator = new Paginator($query);
        $data = $paginator->getQuery()->getResult();

        if(empty($data)) {
            return $result;
        }

        $pages = ceil($paginator->count() / $limit);

        $result['data'] = $data;
        $result['pages'] = $pages;
        $result['page'] = $page;
        $result['limit'] = $limit;

        return $result;
    }

    public function findByTypeQueryBuilder(string $type = null, array $category = null, array $genre = null, string $order = null) {
        $queryBuilder = $this->createQueryBuilder('p');

        if(!empty($type)) {
            $queryBuilder
                ->where("p.type = '$type'");
        }

        if(!empty($category)) {
            $queryBuilder
                ->andWhere("p.category IN (:category)")
                ->setParameter('category', $category);
        }

        if(!empty($genre)) {
            $queryBuilder
                ->andWhere("p.genre IN (:genre)")
                ->setParameter('genre', $genre);
        }

        if($order !== null) {
            if(str_contains($order, "price")) {
                $order = explode("_", $order)[1];

                $queryBuilder
                    ->addOrderBy("p.price", $order);
            }

            if(str_contains($order, "date")) {
                $order = explode("_", $order)[1];

                $queryBuilder
                    ->addOrderBy("p.updatedAt", $order);
            }
        }



        return $queryBuilder;
    }

    //    /**
    //     * @return Product[] Returns an array of Product objects
    //     */
    //    public function findByExampleField($value): array
    //    {
    //        return $this->createQueryBuilder('p')
    //            ->andWhere('p.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->orderBy('p.id', 'ASC')
    //            ->setMaxResults(10)
    //            ->getQuery()
    //            ->getResult()
    //        ;
    //    }

    //    public function findOneBySomeField($value): ?Product
    //    {
    //        return $this->createQueryBuilder('p')
    //            ->andWhere('p.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }
}
