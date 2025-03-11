sampler g_Sampler0 : register(s13);
sampler g_Sampler1 : register(s14);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float2 texcoord6 : TEXCOORD6;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_Sampler0, i.texcoord6);
	r0.x = r0.x * i.texcoord4.x + i.texcoord4.y;
	r1 = i.texcoord2;
	r0.y = r0.w * r1.w + i.texcoord3.w;
	r0.x = r0.x + i.texcoord4.z;
	r0.x = r0.y * r0.x;
	r2 = tex2D(g_Sampler0, i.texcoord);
	r2.xy = r2.yz * i.texcoord4.xx + i.texcoord4.yy;
	r0.w = r2.w * r1.w + i.texcoord3.w;
	r2.xy = r2.xy + i.texcoord4.zz;
	r0.yz = r0.ww * r2.xy;
	r0.xyz = r0.xyz * r1.xyz + i.texcoord3.xyz;
	r0.xyz = -r0.xyz + 1;
	r1.x = min(r0.y, r0.x);
	r2.x = min(r0.z, r1.x);
	r0.xyz = r0.xyz + -r2.xxx;
	r0.w = -r2.x + 1;
	r1.x = 1 / r0.w;
	r0.xyz = r0.xyz * -r1.xxx + 1;
	o.xyz = max(r0.xyz, 0);
	r1 = tex2D(g_Sampler1, i.texcoord1);
	o.w = r0.w * r1.w;

	return o;
}
