const express = require("express");
const bodyParser = require("body-parser");
const mysql = require("mysql");
const bcrypt = require("bcrypt");
const config = require("./config");
const saltRounds = 10;
const multer = require("multer");
const dotenv = require("dotenv");
const path = require("path");
const app = express();
const { v4: uuidv4 } = require("uuid");
const connection = mysql.createConnection(config);
const jwt = require("jsonwebtoken");

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use("/profile", express.static("./assets/profile"));
app.use("/picture", express.static("./assets/product"));
dotenv.config({ path: path.join(__dirname, "/config/.env") });

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "assets/profile/");
  },
  filename: function (req, file, cb) {
    cb(null, uuidv4() + ".png");
  },
});

const upload = multer({
  storage: storage,
  fileFilter: function (req, file, callback) {
    var ext = path.extname(file.originalname);
    if (ext !== ".png" && ext !== ".jpg" && ext !== ".gif" && ext !== ".jpeg") {
      return callback(new Error("Only images are allowed"));
    }
    callback(null, true);
  },
  limits: {
    fileSize: 1024 * 1024,
  },
}).single("image");

connection.connect(function (err) {
  if (err) {
    console.error("error connecting: " + err.stack);
    return;
  }

  console.log("connected as id " + connection.threadId);
});

const handle_image = (req, res, next) => {
  upload(req, res, (err) => {
    if (err instanceof multer.MulterError) return res.send(err).end();
    next();
  });
};

app.post("/api/register", handle_image, async (req, res) => {
  const { firstname, lastname, e_mail, image, password, role } = req.body;
  const hashPassword = await bcrypt.hash(password, saltRounds);
  let sql = "";
  sql = "SELECT user.e_mail FROM user WHERE user.e_mail = ?";
  connection.query(sql, e_mail, (err, result) => {
    if (err) return res.status(403).send(err).end();
    if (result.length == 1)
      return res.status(400).send("E-mail already exists");
    else {
      sql =
        "INSERT INTO user (first_name, last_name, e_mail, password, image_name, role) VALUES (?,?,?,?,?,?)";
      connection.query(
        sql,
        [
          firstname,
          lastname,
          e_mail,
          hashPassword,
          req.file ? req.file.filename : "",
          parseInt(role),
        ],
        (err, result) => {
          if (err) return res.status(403).send(err).end();
          return res.status(200).send("resgister success").end();
        }
      );
    }
  });
});

app.post("/api/login", (req, res) => {
  const { e_mail, password } = req.body;
  const sql = "SELECT * FROM user WHERE user.e_mail = ?";
  connection.query(sql, e_mail, (err, result) => {
    if (err) return res.status(403).send(err).end();
    if (result.length == 0)
      return res.status(200).send("Email not found").end();
    bcrypt.compare(password, result[0].password, function (err, result) {
      if (result) return res.status(200).end();
      return res.status(404).send("Password Incorrect").end();
    });
  });
});

app.get("/api/search/:product_name", (req, res) => {
  const { product_name } = req.params;
  const sql =
    "SELECT product.id, product.product_name, product.image_product, product.description, (SELECT SUM(my_fevorite.score)/ COUNT(my_fevorite.id) FROM product, my_fevorite, type_product WHERE my_fevorite.id_product = product.id AND product.product_name = ?) as start, type_product.type_name FROM product INNER JOIN type_product ON product.id_type = type_product.id WHERE product.product_name = ?";
  connection.query(sql, [product_name, product_name], (err, result) => {
    if (err) return res.status(403).send(err).end();
    return res.json(result).end();
  });
});

app.get("/api/getProduct_byID/:type_id", (req, res) => {
  const { type_id } = req.params;
  const sql =
    "SELECT product.id, product.product_name, product.image_product, product.description , (SELECT SUM(my_fevorite.score)/ COUNT(my_fevorite.id) FROM product, my_fevorite, type_product WHERE my_fevorite.id_product = product.id AND product.id = type_product.id AND product.id_type = ?) as start, type_product.type_name FROM product INNER JOIN type_product ON product.id_type = type_product.id WHERE product.id_type = ?";
  connection.query(sql, [type_id, type_id], (err, result) => {
    if (err) return res.status(403).send(err).end();
    return res.json(result).end();
  });
});

app.get("/api/like_product", (req, res) => {
  const { product_id, user_id, score } = req.query;
  const sql =
    "INSERT INTO my_fevorite (score, id_product, id_user) VALUES (?,?,?)";

  connection.query(sql, [score, product_id, user_id], (err, result) => {
    if (err) return res.status(403).send(err).end();
    return res.status(200).end();
  });
});

app.delete("/api/unlike_product", (req, res) => {
  const { product_id, user_id } = req.query;
  const sql =
    "DELETE FROM my_fevorite WHERE my_fevorite.id_product = ? AND my_fevorite.id_user = ?";
  connection.query(sql, [product_id, user_id], (err, result) => {
    if (err) return res.status(403).send(err).end();
    return res.status(200).end();
  });
});

app.get("/api/getProduct_fevorite/:user_id", (req, res) => {
  const { user_id } = req.params;
  const sql =
    "SELECT product.* FROM product, my_fevorite, user WHERE my_fevorite.id_user = user.id AND product.id = my_fevorite.id_product AND user.id = ?";
  connection.query(sql, user_id, (err, result) => {
    if (err) return res.status(403).send(err).end();
    return res.json(result).end();
  });
});

app.get("/api/forgot_password", (req, res) => {
  const { e_mail } = req.query;
  const sql = "SELECT e_mail FROM user WHERE e_mail = ?";
  connection.query(sql, e_mail, (err, result) => {
    if (err) return res.status(403).send(err).end();
    if (result.length == 0) return res.status(404).send("Not found email");
    const token = jwt.sign({ e_mail: e_mail }, process.env.VERIFY_TOKEN, {
      expiresIn: "15m",
    });
    return res.status(200).send(token).end();
  });
});

app.put("/api/reset_password", async (req, res) => {
  const { token, new_password } = req.body;
  const sql = "UPDATE user  SET password = ? WHERE user.e_mail = ?";
  try {
    const verify_token = jwt.verify(token, process.env.VERIFY_TOKEN);
    const hashPassword = await bcrypt.hash(new_password, saltRounds);
    connection.query(
      sql,
      [hashPassword, verify_token.e_mail],
      (err, result) => {
        if (err) return res.status(403).send(err).end();
        res.status(200).end();
      }
    );
  } catch (error) {
    res.status(403).send("Forbidden").end();
  }
});

const port = process.env.POST || 5000;
app.listen(port, () => {
  console.log(`server is run at port ${port}`);
});
