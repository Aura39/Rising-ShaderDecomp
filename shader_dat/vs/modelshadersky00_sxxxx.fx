float4x4 Rmodelview;
float4 g_CameraParam;
float4x4 proj;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.w = dot(r0, transpose(Rmodelview)[3]);
	r1.x = dot(r0, transpose(Rmodelview)[0]);
	r1.y = dot(r0, transpose(Rmodelview)[1]);
	r1.z = dot(r0, transpose(Rmodelview)[2]);
	o.position.x = dot(r1, transpose(proj)[0]);
	o.position.y = dot(r1, transpose(proj)[1]);
	o.position.z = dot(r1, transpose(proj)[2]);
	o.position.w = dot(r1, transpose(proj)[3]);
	o.texcoord1.xyz = r1.xyz;
	r0.x = -r1.z + -g_CameraParam.x;
	r0.y = 1 / g_CameraParam.y;
	o.texcoord1.w = r0.y * r0.x;
	o.texcoord = i.texcoord.xyxy;

	return o;
}
