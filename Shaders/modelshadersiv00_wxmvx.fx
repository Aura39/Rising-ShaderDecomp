sampler A_Occ_sampler;
sampler Color_1_sampler;
float4 CubeParam;
sampler Shadow_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float3 fog;
float4 g_All_Offset;
float g_ShadowUse;
float4 g_TargetUvParam;
sampler normalmap_sampler;
float4 prefogcolor_enhance;
float4 tile;

struct PS_IN
{
	float3 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float2 r3;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
	r1.xyz = ambient_rate.xyz;
	r0.xyz = r0.xxx * ambient_rate_rate.xyz + r1.xyz;
	r1 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r2 = tex2D(A_Occ_sampler, r1);
	r1 = tex2D(Color_1_sampler, r1.zwzw);
	r3.xy = -r2.yy + r2.xz;
	r0.w = max(abs(r3.x), abs(r3.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r2.xz = (r0.ww >= 0) ? r2.yy : r2.xz;
	r0.xyz = r2.xyz * r0.xyz + i.texcoord2.xyz;
	r2.xy = -r1.yy + r1.xz;
	r0.w = max(abs(r2.x), abs(r2.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r1.xz = (r0.ww >= 0) ? r1.yy : r1.xz;
	r0.w = 1 / ambient_rate.w;
	r1.xyz = r0.www * r1.xyz;
	r1.xyz = r1.xyz * i.color.xyz;
	r0.xyz = r0.xyz * r1.xyz;
	r1.xy = tile.xy * i.texcoord.xy;
	r1 = tex2D(normalmap_sampler, r1);
	r1.xyz = r1.xyz + -1;
	r0.w = abs(CubeParam.w);
	r1.xyz = r0.www * r1.xyz + 1;
	r0.xyz = r0.xyz * r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
