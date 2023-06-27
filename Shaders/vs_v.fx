float4 fogParam;
float4x4 g_Proj;
float4x4 g_WorldView;

struct VS_IN
{
	float4 position : POSITION;
	float4 normal : NORMAL;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.w = dot(r0, transpose(g_WorldView)[3]);
	r1.x = dot(r0, transpose(g_WorldView)[0]);
	r1.y = dot(r0, transpose(g_WorldView)[1]);
	r1.z = dot(r0, transpose(g_WorldView)[2]);
	o.position.x = dot(r1, transpose(g_Proj)[0]);
	o.position.y = dot(r1, transpose(g_Proj)[1]);
	o.position.z = dot(r1, transpose(g_Proj)[2]);
	o.position.w = dot(r1, transpose(g_Proj)[3]);
	o.texcoord1.xyz = r1.xyz;
	r0.x = r1.z + fogParam.y;
	o.texcoord1.w = r0.x * fogParam.x;
	r0.x = dot(i.normal.xyz, transpose(g_WorldView)[0].xyz);
	r0.y = dot(i.normal.xyz, transpose(g_WorldView)[1].xyz);
	r0.z = dot(i.normal.xyz, transpose(g_WorldView)[2].xyz);
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	o.texcoord3 = r0.www * r0.xyz;

	return o;
}
