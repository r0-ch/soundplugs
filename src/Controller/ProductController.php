<?php

namespace App\Controller;

use App\Entity\Product;
use App\Form\ProductDisplayType;
use App\Repository\ProductRepository;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/products', name: 'products_')]
class ProductController extends AbstractController {
    #[Route('/', name: 'index', methods: ['GET', 'POST'])]
    public function getProducts(Request $request, ProductRepository $repository, PaginatorInterface $paginator, Product $product): Response {
        $type = $product->getType();
        $sort = $request->query->get('sort');
        $category = $request->query->all('category');
        $genre = $request->query->all('genre');
        $page = $request->query->getInt('page', 1);

        $form = $this->createForm(ProductDisplayType::class);


        $form->handleRequest($request);


        if($form->isSubmitted() && $form->isValid()) {
            $sort = $form["sort"]->getData();
            $category = $form["category"]->getData();
            $genre = $form["genre"]->getData();


            return $this->redirectToRoute('products_index', [
                'sort' => $sort,
                'category' => $category,
                'genre' => $genre
            ]);
        }

        $products = $paginator->paginate(
            $repository->findByTypeQueryBuilder(null, $category, $genre, $sort),
            $page,
            4
        );

        return $this->render('pages/product/index.html.twig', [
            'products' => $products,
            'form' => $form
        ]);
    }

    #[Route('/{type}', name: 'type', methods: ['GET', 'POST'], requirements: ['type' => 'all|plugin|sample'])]
    public function getSamples(string $type = "all", Product $product, ProductRepository $repository, Request $request, PaginatorInterface $paginator): Response {
        $type = $product->getType();
        $sort = $request->query->get('sort');
        $category = $request->query->all('category');
        $genre = $request->query->all('genre');
        $page = $request->query->getInt('page', 1);


        $form = $this->createForm(ProductDisplayType::class);


        $form->handleRequest($request);


        if($form->isSubmitted() && $form->isValid()) {
            $sort = $form["sort"]->getData();
            $category = $form["category"]->getData();
            $genre = $form["genre"]->getData();


            return $this->redirectToRoute('products_type', [
                'type' => $type,
                'sort' => $sort,
                'category' => $category,
                'genre' => $genre
            ]);
        }

        $products = $paginator->paginate(
            $repository->findByTypeQueryBuilder($type, $category, $genre, $sort),
            $page,
            4
        );


        return $this->render('pages/product/index.html.twig', [
            'products' => $products,
            'type' => $type,
            'form' => $form
        ]);
    }

    #[Route('/{id}/details', name: 'details', methods: ['GET', 'POST'])]
    public function getProduct(int $id, ProductRepository $repository): Response {


        return $this->render('pages/product/details.html.twig', [
            'product' => $repository->find($id),
        ]);
    }
}
