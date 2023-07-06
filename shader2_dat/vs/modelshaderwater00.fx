float4x4 g_WorldView;
float4x4 g_WorldViewProjMatrix;

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

VS_OUT main(float4 position : POSITION)
{
	VS_OUT o;

	float4 r0;
	r0 = position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	o.position.x = dot(r0, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(r0, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(r0, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(r0, transpose(g_WorldViewProjMatrix)[3]);
	o.texcoord.x = dot(r0, transpose(g_WorldView)[0]);
	o.texcoord.y = dot(r0, transpose(g_WorldView)[1]);
	o.texcoord.z = dot(r0, transpose(g_WorldView)[2]);
	o.texcoord.w = dot(r0, transpose(g_WorldView)[3]);

	return o;
}
