float4x4 g_Proj;
float4x4 g_View;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float4 texcoord4 : TEXCOORD4;
	float4 texcoord5 : TEXCOORD5;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.x = dot(i.texcoord2, transpose(g_View)[0]);
	r0.y = dot(i.texcoord3, transpose(g_View)[0]);
	r0.z = dot(i.texcoord4, transpose(g_View)[0]);
	r0.w = dot(i.texcoord5, transpose(g_View)[0]);
	r1 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r0.x = dot(r1, r0);
	r2.x = dot(i.texcoord2, transpose(g_View)[1]);
	r2.y = dot(i.texcoord3, transpose(g_View)[1]);
	r2.z = dot(i.texcoord4, transpose(g_View)[1]);
	r2.w = dot(i.texcoord5, transpose(g_View)[1]);
	r0.y = dot(r1, r2);
	r2.x = dot(i.texcoord2, transpose(g_View)[2]);
	r2.y = dot(i.texcoord3, transpose(g_View)[2]);
	r2.z = dot(i.texcoord4, transpose(g_View)[2]);
	r2.w = dot(i.texcoord5, transpose(g_View)[2]);
	r0.z = dot(r1, r2);
	r2.x = dot(i.texcoord2, transpose(g_View)[3]);
	r2.y = dot(i.texcoord3, transpose(g_View)[3]);
	r2.z = dot(i.texcoord4, transpose(g_View)[3]);
	r2.w = dot(i.texcoord5, transpose(g_View)[3]);
	r0.w = dot(r1, r2);
	r1.x = dot(r0, transpose(g_Proj)[0]);
	r1.y = dot(r0, transpose(g_Proj)[1]);
	r1.z = dot(r0, transpose(g_Proj)[2]);
	r1.w = dot(r0, transpose(g_Proj)[3]);
	o.position = r1;
	o.texcoord = r1;

	return o;
}
