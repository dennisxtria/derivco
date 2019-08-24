# Derivco

This is a public HTTP API which has two purposes:

* list all the available `div-season` pairs
* list all the available fixtures of the requested `div-season` pair

## Let's get started

To start with, the first thing that you need to do is clone the repo from GitHub.

Let's navigate into a directory that you want the application in. Cloning the repo will create a new directory called `derivco` wherever we run the clone command. Here's how:

```bash
git clone https://github.com/dennisxtria/derivco.git
```

Then, `cd` into the `derivco` directory.

```bash
cd derivco
```

Once this is done, you are going to have to install [Docker](https://www.docker.com/products/docker-desktop). After that, you'll have to run the following commands in order to build the image and start the Phoenix server respectively:

```bash
docker build -t derivco:1.0 .
```

```bash
docker-compose up
```

Now, in order to try the HTTP API out, you can do it in either of the following ways:

### Swagger UI

By visiting [localhost:4000/swaggerui](localhost:4000/swaggerui), you can try out getting all the available `div-season` pairs, as well as all the available fixtures of the requested `div-season` pair.

There is also a brief explanation of the models and their attributes.

### Browser

* By visiting [localhost:4000/api/div-season-pairs](localhost:4000/api/div-season-pairs), you will get in a `JSON` format all the available `div-season` pairs.

* By visiting [localhost:4000/api/div-season-pairs/your-division/your-season/fixtures](localhost:4000/api/div-season-pairs/your-division/your-season/fixtures), you will get in a `JSON` format all the available fixtures of the `div-season` pair you selected.

*Note: `your-division` and `your-season` should be replaced with appropriate division and season id's accordingly.*
