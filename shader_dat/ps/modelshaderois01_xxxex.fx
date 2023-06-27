sampler Color_1_sampler;
sampler Shadow_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float3 fog;
float4 g_All_Offset;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 light_Color;
float4 lightpos;
float4 muzzle_light;
float4 muzzle_lightpos;
sampler normalmap_sampler;
float4 point_light1;
float4 point_lightpos1;
float4 prefogcolor_enhance;
float4 specularParam;
float4 tile;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
	float3 texcoord5 : TEXCOORD5;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	float4 r4;
	float3 r5;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1 = r0.w + -0.8;
	clip(r1);
	r1.xy = -r0.yy + r0.xz;
	r0.w = max(abs(r1.x), abs(r1.y));
	r0.w = r0.w + -0.015625;
	r1.x = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.x;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r0.xz = (r0.ww >= 0) ? r0.yy : r0.xz;
	r1.xyz = r0.xyz * i.texcoord5.xyz;
	r0.w = 1 / i.texcoord7.w;
	r2.xy = r0.ww * i.texcoord7.xy;
	r2.xy = r2.xy * float2(0.5, -0.5) + 0.5;
	r2.xy = r2.xy + g_TargetUvParam.xy;
	r2 = tex2D(Shadow_Tex_sampler, r2);
	r0.w = r2.z + g_ShadowUse.x;
	r1.w = -r0.w + 1;
	r1.xyz = r1.www * r1.xyz;
	r2.xyz = r0.xyz * ambient_rate.xyz;
	r1.xyz = r2.xyz * ambient_rate_rate.xyz + r1.xyz;
	r2.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r3.xyz = normalize(r2.xyz);
	r2.xyz = i.texcoord3.xyz;
	r4.xyz = r2.yzx * i.texcoord2.zxy;
	r2.xyz = i.texcoord2.yzx * r2.zxy + -r4.xyz;
	r4.xy = g_All_Offset.xy;
	r4.xy = i.texcoord.xy * tile.xy + r4.xy;
	r4 = tex2D(normalmap_sampler, r4);
	r4.xyz = r4.xyz + -0.5;
	r2.xyz = r2.xyz * -r4.yyy;
	r1.w = r4.x * i.texcoord2.w;
	r2.xyz = r1.www * i.texcoord2.xyz + r2.xyz;
	r2.xyz = r4.zzz * i.texcoord3.xyz + r2.xyz;
	r4.xyz = normalize(r2.xyz);
	r1.w = dot(r3.xyz, r4.xyz);
	r2.xyz = r1.www * point_light1.xyz;
	r2.xyz = r2.xyz * i.texcoord8.xxx;
	r3.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r5.xyz = normalize(r3.xyz);
	r1.w = dot(r5.xyz, r4.xyz);
	r3.xyz = r1.www * muzzle_light.xyz;
	r2.xyz = r3.xyz * i.texcoord8.zzz + r2.xyz;
	r1.w = dot(lightpos.xyz, r4.xyz);
	r2.w = r1.w;
	r3.xyz = r2.www * light_Color.xyz;
	r2.xyz = r3.xyz * r0.www + r2.xyz;
	r2.xyz = r0.xyz * r2.xyz;
	r0.xyz = r0.xyz + specularParam.www;
	r3.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.w = r1.w + -r3.x;
	r1.w = r1.w + 1;
	r1.xyz = r1.xyz * r1.www + r2.xyz;
	r1.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.w = 1 / sqrt(r1.w);
	r2.xyz = -i.texcoord1.xyz * r1.www + lightpos.xyz;
	r3.xyz = normalize(r2.xyz);
	r1.w = dot(r3.xyz, r4.xyz);
	r2.x = pow(r1.w, specularParam.z);
	r2.y = (-r2.w >= 0) ? 0 : 1;
	r2.z = r2.w * r2.y;
	r1.w = (-r1.w >= 0) ? 0 : r2.y;
	r1.w = r2.x * r1.w;
	r2.xyz = r2.zzz * light_Color.xyz;
	r2.xyz = r1.www * r2.xyz;
	r2.xyz = r4.www * r2.xyz;
	r2.xyz = r0.www * r2.xyz;
	r0.w = abs(specularParam.x);
	r2.xyz = r0.www * r2.xyz;
	r0.xyz = r2.xyz * r0.xyz + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}