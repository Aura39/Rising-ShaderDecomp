float4 g_BlurParam;
float4x4 g_OldViewProjection;
float4x4 g_ViewProjection;

struct VS_IN
{
	float4 position : POSITION;
	float4 normal : NORMAL;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 color : COLOR;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float3 r2;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	o.position.z = dot(r0, transpose(g_ViewProjection)[2]);
	r1 = i.normal.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r2.x = dot(r1, transpose(g_OldViewProjection)[0]);
	r2.y = dot(r1, transpose(g_OldViewProjection)[1]);
	r2.z = dot(r1, transpose(g_OldViewProjection)[3]);
	r1.x = dot(r0, transpose(g_ViewProjection)[0]);
	r1.y = dot(r0, transpose(g_ViewProjection)[1]);
	r1.w = dot(r0, transpose(g_ViewProjection)[3]);
	r0.xyz = lerp(r2.xyz, r1.xyw, g_BlurParam.yyy);
	r0.z = 1 / r0.z;
	r0.xy = r0.zz * r0.xy;
	r0.z = 1 / r1.w;
	o.position.xyw = r1.xyw;
	r0.xy = r1.xy * r0.zz + -r0.xy;
	r1.x = r0.x * -g_BlurParam.x;
	r1.y = r0.y * g_BlurParam.x;
	o.color.xy = r1.xy * 2 + 0.5;
	o.color.zw = 1;

	return o;
}
